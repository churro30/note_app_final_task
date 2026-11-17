import 'package:flutter/material.dart';
import 'package:notes_app_task3/theme.dart';

class SideDrawerBorder extends StatelessWidget {
  const SideDrawerBorder({
    super.key,
    required this.child,
    this.isSelected = false,
  });

  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? ThemeColors.accentColor : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
