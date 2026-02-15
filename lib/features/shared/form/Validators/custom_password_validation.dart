import 'package:evertec_technical_test/features/shared/form/Validators/builder/validator_string_builder.dart';

// Clase para validar una contraseña válida (mínimo 8 caracteres, al menos una mayúscula, un número y un símbolo)
class CustomPasswordValidation {
  static String? Function(String?)? validate({
    String? regex,
    String? errorMessage,
  }) {
    return ValidatorStringBuilder()
        .requiredField("Campo requerido")
        .regex(
          regex ??
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
          errorMessage ?? 'Mínimo 8 caracteres: A-z, 0-9 y símbolos.',
        )
        .build();
  }

  // Método para obtener una lista de errores actuales según las reglas de validación
  static List<String> getCurrentErrors(String? value) {
    final errors = <String>[];

    if (value == null || value.isEmpty) {
      errors.add('mayus');
      errors.add('number');
      errors.add('symbol');
      errors.add('minLength');
      return errors;
    }

    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      errors.add('mayus');
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      errors.add('number');
    }
    if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
      errors.add('symbol');
    }
    if (value.length < 8) {
      errors.add('minLength');
    }

    return errors;
  }
}
