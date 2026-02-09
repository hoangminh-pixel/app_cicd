import 'package:bt_management_flutter/core/configs/dio_client.dart';

class UserRepository {
  final DioClient _client;

  UserRepository(this._client);

  Future<User> getProfile() async {
    final res = await _client.dio.get('/me');
    return User();
    // return User.fromJson(res.data);
  }
}


class User {
  
}