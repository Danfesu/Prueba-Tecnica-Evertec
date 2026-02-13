import 'package:evertec_technical_test/core/errors/domain_exception.dart';

class AuthException extends DomainException {
  const AuthException() : super("Error de autenticación");
}
