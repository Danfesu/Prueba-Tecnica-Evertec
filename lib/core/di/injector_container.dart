import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/core/http/api_client.dart';
import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/core/services/network/network_info_impl.dart';
import 'package:evertec_technical_test/core/services/storage/key_value_storage_service.dart';
import 'package:evertec_technical_test/core/services/storage/key_value_storage_service_impl.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service_impl.dart';
import 'package:evertec_technical_test/features/auth/auth_di.dart';
import 'package:evertec_technical_test/features/home/home_di.dart';
import 'package:evertec_technical_test/features/main_layout/layout_di.dart';
import 'package:evertec_technical_test/features/settings/settings_di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InjectorContainer {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    // External
    instance.registerLazySingleton(() => FlutterSecureStorage());
    instance.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(instance()),
    );
    instance.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );
    instance.registerLazySingleton(() => InternetConnectionChecker.instance);
    instance.registerLazySingleton(() => Connectivity());
    instance.registerLazySingleton(() => ApiClient());
    instance.registerLazySingleton(() => AppDatabase());
    instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(instance(), instance()),
    );
    // Aquí se registrarían las dependencias globales
    initSettingsFeature();
    initAuthFeature();
    initLayoutFeature();
    initHomeFeature();
  }
}
