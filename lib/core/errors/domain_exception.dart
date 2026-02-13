abstract class DomainException implements Exception {
  final String message;
  const DomainException(this.message);
}
