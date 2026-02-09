import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus {
  online,
  offline,
}

class NetworkStatusService {
  static final NetworkStatusService _instance =
      NetworkStatusService._internal();

  factory NetworkStatusService() => _instance;

  NetworkStatusService._internal();

  final _controller = StreamController<NetworkStatus>.broadcast();
  Stream<NetworkStatus> get stream => _controller.stream;

  NetworkStatus? _current;

  Future<void> start() async {
    // final result = await Connectivity().checkConnectivity();
    // _emit(result);

    Connectivity().onConnectivityChanged.listen((result) {
      _emit(result);
    });
  }

  bool _initialized = false;

  void _emit(List<ConnectivityResult> result) {
    final status = result.contains(ConnectivityResult.none)
        ? NetworkStatus.offline
        : NetworkStatus.online;

    if (!_initialized) {
      _initialized = true;
      _current = status;
      log('init status $status');
      return; // ⛔ KHÔNG emit toast
    }

    if (status != _current) {
      _current = status;
      log('emit $status');
      _controller.add(status);
    }
  }
}
