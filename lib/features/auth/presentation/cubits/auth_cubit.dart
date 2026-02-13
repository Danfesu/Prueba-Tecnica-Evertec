import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_google.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_out.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SingInGoogle singInGoogle;
  final SingOut singOut;

  AuthCubit(this.singInGoogle, this.singOut) : super(AuthState.initial());

  void loginWithGoogle() async {
    emit(AuthState.loading());

    try {
      final user = await singInGoogle();
      emit(AuthState.authenticated(user: user));
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  void logout() async {
    emit(AuthState.loading());
    try {
      await singOut();
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  void validateAuthStatus() {
    // Aquí podrías verificar el estado de autenticación del usuario
    // Por ejemplo, podrías consultar un repositorio o servicio de autenticación
    // y emitir el estado correspondiente (autenticado, no autenticado, etc.)
  }
}
