import 'package:evertec_technical_test/features/auth/auth_di.dart';
import 'package:get_it/get_it.dart';

class InjectorContainer {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    // Aquí se registrarían las dependencias globales
    initAuthFeature();
  }
}
