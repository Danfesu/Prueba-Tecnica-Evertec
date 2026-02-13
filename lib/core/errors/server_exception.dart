import 'package:evertec_technical_test/core/errors/domain_exception.dart';

class ServerException extends DomainException {
  const ServerException() : super("Error del servidor");
}
