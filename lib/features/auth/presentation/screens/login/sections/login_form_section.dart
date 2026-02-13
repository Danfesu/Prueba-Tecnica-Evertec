import 'package:evertec_technical_test/features/shared/form/Validators/custom_email_validator.dart';
import 'package:evertec_technical_test/features/shared/form/Validators/custom_password_validation.dart';
import 'package:evertec_technical_test/features/shared/form/custom_form_general.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item.dart';
import 'package:evertec_technical_test/features/shared/form/form_items/form_item_string.dart';
import 'package:evertec_technical_test/features/shared/widgets/buttons/general_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> _passwordErrors = <String>[];
  bool _isChangePassword = false;

  @override
  Widget build(BuildContext context) {
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

    void onSubmit() {
      _formKey.currentState?.save();
      if (!_formKey.currentState!.validate()) {
        return;
      }
      // TODO: Implementar lógica de autenticación aquí
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
