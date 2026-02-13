import 'package:evertec_technical_test/features/shared/form/form_items/form_item_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el input de dropdown (select) personalizado en el formulario
class CustomBuilderDropDown extends StatelessWidget {
  final FormItemSelect formItem;

  const CustomBuilderDropDown({super.key, required this.formItem});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
    );

    // Usar FormBuilderDropdown para el campo de selección
    return FormBuilderDropdown<String>(
      name: formItem.name,
      validator: formItem.validator,
      initialValue: formItem.defaultValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      dropdownColor: colors.surfaceBright,
      borderRadius: BorderRadius.circular(10),
      elevation: 8,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      menuMaxHeight:
          300, // Evita que cubra toda la pantalla si hay muchas opciones
      isExpanded: true, // Evita errores de overflow si el texto es largo
      style: TextStyle(color: colors.onSurface, fontSize: 16),
      items: formItem.options
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      onChanged: formItem.onChanged,
      hint: Text(''),
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
    );
  }
}
