import 'package:evertec_technical_test/features/shared/form/form_items/form_item_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Clase para el input de switch en el formulario
class CustomBuilderSwitch extends StatelessWidget {
  final FormItemSwitch formItem;

  const CustomBuilderSwitch({super.key, required this.formItem});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final name = formItem.name;
    final title = formItem.label;
    final subTitle = formItem.subTitle;
    final onChangedValue = formItem.onChanged;
    final activeColor = formItem.activeColor;
    final controlAffinity = formItem.controlAffinity;
    final initialValue = formItem.defaultValue;
    final validator = formItem.validator;

    return FormBuilderSwitch(
      name: name,
      title: Text(title ?? "", style: textTheme.bodyLarge),
      onChanged: onChangedValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      subtitle: subTitle != null
          ? Text(subTitle, style: textTheme.bodySmall)
          : null,
      activeColor: activeColor,
      controlAffinity: controlAffinity,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ),
      validator: validator,
    );
  }
}
