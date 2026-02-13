import 'package:evertec_technical_test/core/http/api_client.dart';
import 'package:evertec_technical_test/core/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/core/storage/secure_storage_service_impl.dart';
import 'package:evertec_technical_test/features/auth/auth_di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class InjectorContainer {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    // External
    instance.registerLazySingleton(() => FlutterSecureStorage());
    instance.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(instance()),
    );
    instance.registerLazySingleton(() => ApiClient());
    // Aquí se registrarían las dependencias globales
    initAuthFeature();
  }
}
