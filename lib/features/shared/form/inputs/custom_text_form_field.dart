import 'package:evertec_technical_test/features/shared/form/form_items/form_item_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el input de texto en el formulario
class CustomTextFormField extends StatefulWidget {
  final FormItemString formItem;

  const CustomTextFormField({super.key, required this.formItem});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
    );

    final name = widget.formItem.name;
    final label = widget.formItem.label;
    final hint = widget.formItem.hintText;
    final prefixIcon = widget.formItem.prefixIcon;
    final validator = widget.formItem.validator;
    final obscureText = widget.formItem.obscureText;
    final onChangedValue = widget.formItem.onChanged;
    final defaultValue = widget.formItem.defaultValue;

    return FormBuilderTextField(
      name: name,
      initialValue: defaultValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChangedValue,
      validator: validator,
      obscureText: obscureText && !showPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surfaceBright,
        contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 8.0),
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        isDense: true,
        labelText: label,
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}
