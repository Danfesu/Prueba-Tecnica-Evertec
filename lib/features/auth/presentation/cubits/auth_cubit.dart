import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_credential.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_google.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_out.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:evertec_technical_test/features/shared/extesions/error_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SingInGoogle _singInGoogle;
  final SingOut _singOut;
  final SingInCredential _singInCredential;

  AuthCubit(this._singInGoogle, this._singOut, this._singInCredential)
    : super(AuthState.initial());

  void loginWithGoogle(BuildContext context) async {
    emit(AuthState.loading());

    try {
      final user = await _singInGoogle();
      emit(AuthState.authenticated(user: user));
    } catch (e) {
      emit(AuthState.error(message: "Error al cargar"));
      context.showErrorDialog(
        "Sin conexion",
        "Revisa tu internet y vuleve a intentarlo",
        () {
          loginWithGoogle(context);
        },
      );
      return;
    }
  }

  void loginWithCredentials(String email, String password) async {
    emit(AuthState.loading());

    try {
      final user = await _singInCredential(Email(email), Password(password));
      emit(AuthState.authenticated(user: user));
    } on FormatException {
      emit(
        AuthState.error(message: "Formato de correo o contraseña incorrecto"),
      );
      return;
    } catch (e) {
      emit(AuthState.error(message: "Credenciales invalidas"));
      return;
    }
  }

  void logout() async {
    emit(AuthState.loading());
    try {
      await _singOut();
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: "Error al cerrar sesión"));
      return;
    }
  }

  void validateAuthStatus() {
    // Aquí podrías verificar el estado de autenticación del usuario
    // Por ejemplo, podrías consultar un repositorio o servicio de autenticación
    // y emitir el estado correspondiente (autenticado, no autenticado, etc.)
  }
}
