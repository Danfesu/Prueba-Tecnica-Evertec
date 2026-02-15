import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/shared/form/Validators/custom_email_validator.dart';
import 'package:evertec_technical_test/features/shared/form/Validators/custom_password_validation.dart';
import 'package:evertec_technical_test/features/shared/form/custom_form_general.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_string.dart';
import 'package:evertec_technical_test/features/shared/widgets/buttons/general_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Sección que contiene el formulario de inicio de sesión.
///
/// Esta clase:
/// - Construye dinámicamente los campos del formulario.
/// - Aplica validaciones personalizadas para email y contraseña.
/// - Muestra errores de validación en tiempo real.
/// - Ejecuta el proceso de autenticación mediante [AuthCubit].
class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  /// Clave global para gestionar el estado del formulario.
  final _formKey = GlobalKey<FormBuilderState>();

  /// Lista de errores actuales de validación de la contraseña.
  List<String> _passwordErrors = <String>[];

  /// Indica si el usuario ha comenzado a modificar el campo contraseña.
  bool _isChangePassword = false;

  @override
  Widget build(BuildContext context) {
    /// Configuración dinámica de los campos del formulario.
    ///
    /// Incluye:
    /// - Campo de email con validador personalizado.
    /// - Campo de contraseña con validación avanzada en tiempo real.
    final List<FormItem> configurationFormLogin = [
      FormItemString(
        name: "email",
        validator: CustomEmailValidator.validate(),
        topText: "Correo electrónico",
        hintText: "ejemplo@correo.com",
        prefixIcon: Icons.email_outlined,
      ),
      FormItemString(
        name: "password",
        validator: CustomPasswordValidation.validate(errorMessage: ''),
        topText: "Password",
        hintText: "Enter your password",
        prefixIcon: Icons.lock_outline,
        obscureText: true,
        onChanged: (value) => setState(() {
          _isChangePassword = true;
          _passwordErrors = CustomPasswordValidation.getCurrentErrors(value);
        }),
        child: _isChangePassword
            ? _buildPasswordValidationErrors(_passwordErrors, context)
            : null,
      ),
    ];

    /// Maneja el envío del formulario.
    ///
    /// - Guarda el estado actual.
    /// - Ejecuta validaciones.
    /// - Si todo es correcto, llama al método
    ///   `loginWithCredentials` del [AuthCubit].
    void onSubmit() {
      _formKey.currentState?.save();
      if (!_formKey.currentState!.validate()) {
        return;
      }
      context.read<AuthCubit>().loginWithCredentials(
        _formKey.currentState!.value["email"],
        _formKey.currentState!.value["password"],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormGeneral(
            formConfiguration: configurationFormLogin,
            formKey: _formKey,
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: GeneralButton(text: "Iniciar Sesión", onPressed: onSubmit),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              NoImplemented.showNotImplementedDialog(context);
            },
            child: Text(
              "¿Olvidaste tu contraseña?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye la lista visual de errores de validación
  /// de la contraseña.
  ///
  /// Cada requisito se muestra dinámicamente indicando
  /// si se cumple o no mediante íconos y colores.
  Widget _buildPasswordValidationErrors(
    List<String> errors,
    BuildContext context,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        _buildCheckError(
          errors.contains('minLength'),
          colors.tertiary,
          colors.onTertiary,
          'minimo 8 caracteres',
        ),
        _buildCheckError(
          errors.contains('number'),
          colors.tertiary,
          colors.onTertiary,
          'un número',
        ),
        _buildCheckError(
          errors.contains('symbol'),
          colors.tertiary,
          colors.onTertiary,
          'un carácter especial',
        ),
        _buildCheckError(
          errors.contains('mayus'),
          colors.tertiary,
          colors.onTertiary,
          'una letra en mayúscula',
        ),
      ],
    );
  }

  /// Construye un widget que representa el estado
  /// de un requisito de validación.
  ///
  /// Si el requisito no se cumple:
  /// - Se muestra un ícono circular.
  ///
  /// Si el requisito se cumple:
  /// - Se muestra un ícono de check.
  ///
  /// [isError] indica si el requisito aún no se cumple.
  Widget _buildCheckError(
    bool isError,
    Color successColor,
    Color pendingColor,
    String message,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError
                ? pendingColor.withValues(alpha: 0.3)
                : successColor.withValues(alpha: 0.2),
          ),
          child: Icon(
            isError ? Icons.circle : Icons.check,
            color: isError ? pendingColor : successColor,
            size: 10,
          ),
        ),
        SizedBox(width: 4),
        Text(message),
      ],
    );
  }
}
