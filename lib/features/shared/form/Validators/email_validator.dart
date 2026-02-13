import 'package:evertec_technical_test/features/shared/form/Validators/builder/validator_string_builder.dart';

// Clase para validar que un campo de texto sea un email válido
class EmailValidator {
  static String? Function(String?)? validate({
    String? regex,
    String? errorMessage,
  }) {
    return ValidatorStringBuilder()
        .requiredField('Campo requerido')
        .regex(
          regex ?? r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          errorMessage ?? 'Debe ser un email válido',
        )
        .build();
  }
}
