import 'package:flutter/material.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/theme.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<Gender>(
      initialValue: selectedGender,
      validator: (value) => value == null ? selectGenderMessage : null,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioGroup<Gender>(
            groupValue: state.value,
            onChanged: (value) {
              state.didChange(value);
              onChanged(value);
            },
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(maleText),
                    leading: Radio<Gender>(value: Gender.male),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(femaleText),
                    leading: Radio<Gender>(value: Gender.female),
                  ),
                ),
              ],
            ),
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                state.errorText!,
                style: TextStyle(color: ThemeColors.textColor),
              ),
            ),
        ],
      ),
    );
  }
}
