import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_app/plugins/local_auth_plugin.dart';


enum LocalAuthStatus { authenticated, notAuthenticated, authenticating, error }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
    this.didAuthenticate = false,
    this.status = LocalAuthStatus.notAuthenticated,
    this.message = '',
  });

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) =>
      LocalAuthState(
        didAuthenticate: didAuthenticate ?? this.didAuthenticate,
        status: status ?? this.status,
        message: message ?? this.message,
      );
}

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit() : super(LocalAuthState());

  Future<void> authenticateUser() async {
    emit(state.copyWith(status: LocalAuthStatus.authenticating));

    final (didAuthenticate, message) = await LocalAuthPlugin.authenticate();

    emit(state.copyWith(
      didAuthenticate: didAuthenticate,
      message: message,
      status: didAuthenticate
          ? LocalAuthStatus.authenticated
          : LocalAuthStatus.notAuthenticated,
    ));
  }

  Future<void> checkBiometrics() async {
    try {
      final canCheck = await LocalAuthPlugin.checkBiometrics();
      emit(state.copyWith(message: 'Puede revisar biométricos: $canCheck'));
    } catch (e) {
      emit(state.copyWith(
          status: LocalAuthStatus.error, message: 'Error al comprobar biométricos'));
    }
  }
}
