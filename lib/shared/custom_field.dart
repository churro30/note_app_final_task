import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.onSaved,
    required this.fieldType,
    required this.fieldLabel,
    this.value,
    this.state,
    this.length,
  });

  final FormFieldSetter<String> onSaved;
  final String fieldType;
  final String fieldLabel;
  final String? value;
  final String? state;

  final int? length;

  @override
  Widget build(BuildContext context) {
    final isMultiline = fieldType.toLowerCase() == 'text';
    final type = fieldType.toLowerCase();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        initialValue: value,
        readOnly: state == 'preview',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $fieldLabel';
          }

          if (type == 'numbers' && !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return '$fieldLabel must contain only numbers';
          }
          if (type == 'letters' && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
            return '$fieldLabel must contain only letters';
          }
          return null;
        },
        maxLength: length,
        keyboardType: isMultiline
            ? TextInputType.multiline
            : type == 'numbers'
            ? TextInputType.number
            : null,

        textInputAction: TextInputAction.newline,
        maxLines: isMultiline ? null : 1,
        onSaved: onSaved,
      ),
    );
  }
}
