import 'package:evertec_technical_test/features/shared/form/form_items/form_item_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el grupo de opciones (radio buttons) personalizado en el formulario
class CustomBuilderRatioGroup extends StatelessWidget {
  final FormItemRadioGroup formItem;

  const CustomBuilderRatioGroup({super.key, required this.formItem});

  @override
  Widget build(BuildContext context) {
    final name = formItem.name;
    final label = formItem.label;
    final validator = formItem.validator;
    final options = formItem.options;
    final defaultOption = formItem.defaultValue;
    final orientation = formItem.orientation;
    final activeColor = formItem.activeColor;
    final controlAffinity = formItem.controlAffinity;
    final onChangedValue = formItem.onChanged;

    return FormBuilderRadioGroup<String>(
      name: name,
      orientation: orientation,
      activeColor: activeColor,
      controlAffinity: controlAffinity,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(labelText: label, border: InputBorder.none),
      validator: validator,
      initialValue: defaultOption,
      onChanged: onChangedValue,
      options: options
          .map(
            (option) =>
                FormBuilderFieldOption(value: option, child: Text(option)),
          )
          .toList(),
    );
  }
}
