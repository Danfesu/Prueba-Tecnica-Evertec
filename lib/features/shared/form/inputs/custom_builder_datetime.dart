import 'package:evertec_technical_test/features/shared/form/form_items/form_item_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el input de fecha y hora en el formulario
class CustomBuilderDatetime extends StatelessWidget {
  final FormItemDateTime formItem;

  const CustomBuilderDatetime({super.key, required this.formItem});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Definir un borde común para los diferentes estados del campo
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
    );
    // Usar FormBuilderDateTimePicker para el campo de fecha y hora
    return FormBuilderDateTimePicker(
      name: formItem.name,
      initialValue: formItem.initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputType: formItem.inputType ?? InputType.date, //
      onChanged: formItem.onChanged,
      validator: formItem.validator,
      format: formItem.format,
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
        labelText: formItem.label,
        hintText: formItem.hintText,
        focusColor: colors.primary,
        prefixIcon: formItem.prefixIcon != null
            ? Icon(formItem.prefixIcon!)
            : null,
      ),
      initialDate: formItem.initialValue,
      firstDate: formItem.firstDate, // Fecha mínima permitida
      lastDate: formItem.lastDate, // Fecha máxima (hoy)
    );
  }
}
