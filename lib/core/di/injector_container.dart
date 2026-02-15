import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Core
import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/core/http/api_client.dart';
import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/core/services/network/network_info_impl.dart';
import 'package:evertec_technical_test/core/services/storage/key_value_storage_service.dart';
import 'package:evertec_technical_test/core/services/storage/key_value_storage_service_impl.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service_impl.dart';

// Features
import 'package:evertec_technical_test/features/auth/auth_di.dart';
import 'package:evertec_technical_test/features/home/home_di.dart';
import 'package:evertec_technical_test/features/main_layout/layout_di.dart';
import 'package:evertec_technical_test/features/settings/settings_di.dart';

/// Contenedor de inyección de dependencias de la aplicación.
///
/// Utiliza GetIt para gestionar el ciclo de vida de las dependencias.
///
/// **Uso:**
/// ```dart
/// // En main.dart
/// await InjectorContainer.init();
///
/// // En cualquier parte del código
/// final apiClient = InjectorContainer.instance<ApiClient>();
/// final database = InjectorContainer.instance<AppDatabase>();
/// ```
///
/// **Orden de inicialización:**
/// 1. Dependencias externas (paquetes de terceros)
/// 2. Servicios core (storage, network, database)
/// 3. Features (auth, home, settings, etc.)
abstract class InjectorContainer {
  // Constructor privado para prevenir instanciación
  InjectorContainer._();

  /// Instancia global de GetIt.
  ///
  /// Usar `InjectorContainer.instance<T>()` para obtener dependencias.
  static final GetIt instance = GetIt.instance;

  /// Inicializa todas las dependencias de la aplicación.
  ///
  /// Debe ser llamado en `main()` antes de `runApp()`.
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await InjectorContainer.init();
  ///   runApp(const MyApp());
  /// }
  /// ```
  static Future<void> init() async {
    // ══════════════════════════════════════════════════════════════
    // DEPENDENCIAS EXTERNAS (Paquetes de terceros)
    // ══════════════════════════════════════════════════════════════
    _registerExternalDependencies();

    // ══════════════════════════════════════════════════════════════
    // SERVICIOS CORE (Storage, Network, Database, HTTP)
    // ══════════════════════════════════════════════════════════════
    _registerCoreServices();

    // ══════════════════════════════════════════════════════════════
    // FEATURES (Auth, Home, Settings, etc.)
    // ══════════════════════════════════════════════════════════════
    _registerFeatures();
  }

  /// Registra dependencias de paquetes externos.
  ///
  /// - FlutterSecureStorage
  /// - InternetConnectionChecker
  /// - Connectivity
  static void _registerExternalDependencies() {
    // Almacenamiento seguro
    instance.registerLazySingleton(() => const FlutterSecureStorage());

    // Verificador de conexión a internet
    instance.registerLazySingleton(() => InternetConnectionChecker.instance);

    // Monitor de conectividad
    instance.registerLazySingleton(() => Connectivity());
  }

  /// Registra servicios core de la aplicación.
  ///
  /// - Storage (Seguro y Key-Value)
  /// - Network (Verificación de conexión)
  /// - Database (Drift)
  /// - HTTP Client (Dio)
  static void _registerCoreServices() {
    // ══════════════════════════════════════════════════════════════
    // STORAGE
    // ══════════════════════════════════════════════════════════════

    // Almacenamiento seguro (tokens, credenciales)
    instance.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(instance()),
    );

    // Almacenamiento key-value (preferencias, configuración)
    instance.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );

    // ══════════════════════════════════════════════════════════════
    // NETWORK
    // ══════════════════════════════════════════════════════════════

    // Verificador de conectividad y conexión a internet
    instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        instance<InternetConnectionChecker>(),
        instance<Connectivity>(),
      ),
    );

    // ══════════════════════════════════════════════════════════════
    // DATABASE
    // ══════════════════════════════════════════════════════════════

    // Base de datos local (Drift)
    instance.registerLazySingleton(() => AppDatabase());

    // ══════════════════════════════════════════════════════════════
    // HTTP CLIENT
    // ══════════════════════════════════════════════════════════════

    // Cliente HTTP para peticiones a la API
    instance.registerLazySingleton(() => ApiClient());
  }

  /// Registra las dependencias de cada feature.
  ///
  /// Cada feature tiene su propio archivo `*_di.dart` que contiene
  /// el registro de sus dependencias específicas.
  static void _registerFeatures() {
    initSettingsFeature(); // Ajustes de la app
    initAuthFeature(); // Autenticación y autorización
    initLayoutFeature(); // Layout principal y navegación
    initHomeFeature(); // Home y productos
  }
}
