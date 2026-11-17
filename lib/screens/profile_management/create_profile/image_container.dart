import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notes_app_task3/theme.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, this.image});
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(top: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ThemeColors.accentColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: image == null
            ? const Icon(LucideIcons.camera, size: 50, color: Colors.black)
            : Image.file(image!, fit: BoxFit.cover),
      ),
    );
  }
}
