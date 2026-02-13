import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  /// Estado inicial
  const factory AuthState.initial() = _Initial;

  /// Estado de carga
  const factory AuthState.loading() = _Loading;

  /// Estado no autenticado
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Estado autenticado
  const factory AuthState.authenticated({required AppUser user}) =
      _Authenticated;

  /// Estado de error
  const factory AuthState.error({required String message}) = _Error;
}
