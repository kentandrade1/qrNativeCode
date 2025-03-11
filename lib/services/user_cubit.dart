import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_app/models/user.dart';
import 'package:seek_app/services/dataBaseHelper.dart';

enum UserStatus { initial, userExists, userNotFound, error }

class UserState {
  final User? user;
  final UserStatus status;
  final String message;

  UserState({
    this.user,
    this.status = UserStatus.initial,
    this.message = '',
  });

  UserState copyWith({
    User? user,
    UserStatus? status,
    String? message,
  }) =>
      UserState(
        user: user ?? this.user,
        status: status ?? this.status,
        message: message ?? this.message,
      );
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  Future<void> checkUser() async {
    try {
      final user = await DatabaseHelper().getUser();
      if (user != null) {
        emit(state.copyWith(user: user, status: UserStatus.userExists));
      } else {
        emit(state.copyWith(status: UserStatus.userNotFound));
      }
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error, message: e.toString()));
    }
  }

  Future<void> saveUsername(String username) async {
    try {
      User user = User(username: username);
      await DatabaseHelper().insertUser(user);
      emit(state.copyWith(user: user, status: UserStatus.userExists));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error, message: 'Error al guardar el usuario'));
    }
  }
}
