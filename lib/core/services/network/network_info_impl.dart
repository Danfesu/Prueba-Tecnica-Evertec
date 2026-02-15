import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'network_info.dart';

/// Implementación de [NetworkInfo] que verifica conectividad real.
///
/// Combina dos paquetes para verificación completa:
/// - [Connectivity]: Detecta cambios en WiFi/datos móviles (rápido pero no confiable)
/// - [InternetConnectionChecker]: Verifica conexión real a internet (ping a servidores)
///
/// **Por qué usar ambos:**
/// - Connectivity puede decir "conectado" pero sin internet real
/// - InternetConnectionChecker hace ping real pero es más lento
/// - Combinados dan la mejor experiencia UX
///
class NetworkInfoImpl implements NetworkInfo {
  /// Verifica conexión real a internet mediante ping.
  final InternetConnectionChecker connectionChecker;

  /// Detecta cambios en conectividad WiFi/datos móviles.
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectionChecker, this.connectivity);

  /// Verifica si hay conexión a internet en este momento.
  /// Hace ping real a servidores para verificar conectividad.
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  /// Stream que emite cuando cambia el estado de conexión.
  ///
  /// Escucha cambios en WiFi/datos móviles y verifica conexión real
  /// cada vez que hay un cambio.
  ///
  /// **Flujo:**
  /// 1. Connectivity detecta cambio (WiFi on/off, datos on/off)
  /// 2. asyncMap verifica conexión real con ping
  /// 3. Stream emite `true` si hay internet, `false` si no
  @override
  Stream<bool> get onConnectivityChanged {
    return connectivity.onConnectivityChanged.asyncMap((_) async {
      return await connectionChecker.hasConnection;
    });
  }
}
