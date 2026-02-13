import 'package:form_builder_validators/form_builder_validators.dart';

// Clase para construir validadores de tipo String de manera fluida (builder pattern)
class ValidatorStringBuilder {
  bool _isRequired = false;
  String? _requiredMessage;

  String? _regexPattern;
  String? _regexMessage;

  int? _minLength;
  String? _minLengthMessage;

  int? _maxLength;
  String? _maxLengthMessage;

  String? _equalsValue;
  String? _equalsMessage;

  // Método para agregar validación de campo requerido
  ValidatorStringBuilder requiredField([String? errorMessage]) {
    _isRequired = true;
    _requiredMessage = errorMessage ?? 'Field is required';
    return this;
  }

  // Método para agregar validación de expresión regular
  ValidatorStringBuilder regex(String pattern, [String? errorMessage]) {
    _regexPattern = pattern;
    _regexMessage = errorMessage ?? 'Invalid format';
    return this;
  }

  // Método para agregar validación de longitud mínima
  ValidatorStringBuilder minLength(int value, [String? errorMessage]) {
    _minLength = value;
    _minLengthMessage = errorMessage ?? 'Min length is $value';
    return this;
  }

  // Método para agregar validación de longitud máxima
  ValidatorStringBuilder maxLength(int value, [String? errorMessage]) {
    _maxLength = value;
    _maxLengthMessage = errorMessage ?? 'Max length is $value';
    return this;
  }

  // Método para agregar validación de igualdad con un valor específico
  ValidatorStringBuilder equalsTo(String value, [String? errorMessage]) {
    _equalsValue = value;
    _equalsMessage = errorMessage ?? 'Value must be $value';
    return this;
  }

  // Método para construir la función de validación final a partir de las reglas definidas
  String? Function(String?) build() {
    final validators = <String? Function(String?)>[];

    if (_isRequired) {
      validators.add(
        FormBuilderValidators.required(errorText: _requiredMessage),
      );
    }

    if (_regexPattern != null) {
      validators.add(
        FormBuilderValidators.match(
          RegExp(_regexPattern!),
          errorText: _regexMessage,
        ),
      );
    }

    if (_minLength != null) {
      validators.add(
        FormBuilderValidators.minLength(
          _minLength!,
          errorText: _minLengthMessage,
        ),
      );
    }

    if (_maxLength != null) {
      validators.add(
        FormBuilderValidators.maxLength(
          _maxLength!,
          errorText: _maxLengthMessage,
        ),
      );
    }

    if (_equalsValue != null) {
      validators.add(
        FormBuilderValidators.equal(_equalsValue!, errorText: _equalsMessage),
      );
    }

    if (validators.isEmpty) return (_) => null;

    return FormBuilderValidators.compose(validators);
  }
}
