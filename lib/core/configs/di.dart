import 'package:bt_management_flutter/core/configs/dio_client.dart';
import 'package:bt_management_flutter/data/repositories/user_repository.dart';
import 'package:bt_management_flutter/screens/user/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<DioClient>()),
  );

  getIt.registerFactory(() => UserBloc(getIt<UserRepository>()));
}
