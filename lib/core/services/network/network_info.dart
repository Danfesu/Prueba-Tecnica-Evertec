/// Interface para verificación de conectividad de red.
/// Define el contrato para implementaciones que verifican
/// conexión a internet.
abstract class NetworkInfo {
  /// Verifica si hay conexión a internet en este momento.
  ///
  /// Retorna `true` si hay conexión real a internet.
  Future<bool> get isConnected;

  /// Stream que emite cuando cambia el estado de conexión.
  ///
  /// Emite `true` cuando se conecta, `false` cuando se desconecta.
  Stream<bool> get onConnectivityChanged;
}
