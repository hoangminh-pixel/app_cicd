import 'package:bt_management_flutter/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repo;

  UserBloc(this.repo) : super(UserInitial()) {
    // on<LoadProfile>(_onLoadProfile);
  }

  // Future<void> _onLoadProfile(
  //   LoadProfile event,
  //   Emitter<UserState> emit,
  // ) async {
  //   emit(UserLoading());

  //   try {
  //     final user = await repo.getProfile();
  //     emit(UserLoaded(user));
  //   } on DioException catch (e) {
  //     emit(UserError(_mapError(e)));
  //   }
  // }
}
