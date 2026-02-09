import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: "https://demo-cmms.izisolution.vn/icmms_webservice/",
            connectTimeout: const Duration(seconds: 60000),
            receiveTimeout: const Duration(seconds: 60000),
            headers: {
              "Accept": "application/json",
              'Content-Type': 'application/json'
            },
          ),
        ) {
    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
      ConnectivityInterceptor(connectivity: Connectivity()),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          log("👉 REQUEST: ${options.method} ${options.uri} ${options.data}");

          final token = await _getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('data ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // Nếu token hết hạn (401)
          if (e.response?.statusCode == 401) {
            try {
              // Thử refresh token
              final newToken = await _refreshToken();

              if (newToken != null) {
                // Lưu lại token mới
                await _saveToken(newToken);

                // Gắn token mới vào header request cũ
                final retryRequest = e.requestOptions;
                retryRequest.headers["Authorization"] = "Bearer $newToken";

                // Gửi lại request cũ với token mới
                final response = await dio.fetch(retryRequest);
                return handler.resolve(response);
              }
            } catch (err) {
              return handler.reject(e); // Refresh thất bại
            }
          }

          return handler.next(e);
        },
      ),
    ]);
  }

  // TODO: implement token storage (SharedPreferences hoặc SecureStorage)

  Future<String?> _getToken() async {
    // Ví dụ: lấy token từ SharedPreferences
    return null;
  }

  Future<void> _saveToken(String token) async {
    // Lưu token vào SharedPreferences hoặc SecureStorage
  }

  Future<String?> _getRefreshToken() async {
    // Lấy refresh token từ storage
    return null;
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dio.post("/auth/refresh", data: {
        "refresh_token": refreshToken,
      });

      return response.data["access_token"] as String?;
    } catch (e) {
      print("Refresh token failed: $e");
      return null;
    }
  }
}



class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity;

  ConnectivityInterceptor({required Connectivity connectivity})
      : _connectivity = connectivity;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(DioException(
          requestOptions: err.requestOptions, message: 'No internet connection', type: DioExceptionType.connectionError));
    }
    return handler.next(err);
  }
}
