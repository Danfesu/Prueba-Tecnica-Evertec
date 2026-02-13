import 'package:evertec_technical_test/core/errors/domain_exception.dart';

class NetworkException extends DomainException {
  const NetworkException() : super("Sin conexión a internet");
}
