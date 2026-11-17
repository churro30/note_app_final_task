import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:notes_app_task3/theme.dart';
import 'package:notes_app_task3/screens/profile_management/create_profile/image_container.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({
    super.key,
    required this.selectedImage,
    required this.onChanged,
    required this.onPickImage,
  });

  final File? selectedImage;
  final ValueChanged<File?> onChanged;
  final Future<File?> Function() onPickImage;

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      initialValue: selectedImage,
      validator: (value) => value == null ? selectImageMessage : null,
      builder: (state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () async {
                final image = await onPickImage();
                if (image != null) {
                  state.didChange(image);
                  onChanged(image);
                }
              },
              child: ImageContainer(image: state.value),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: ThemeColors.textColor, fontSize: 15),
                ),
              ),
          ],
        );
      },
    );
  }
}
