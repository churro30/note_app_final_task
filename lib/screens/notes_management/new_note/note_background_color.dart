import 'package:flutter/material.dart';

class NoteBackgroundColor extends StatelessWidget {
  const NoteBackgroundColor({
    super.key,
    required this.colorText,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.state,
  });

  final String colorText;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final String? state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: isSelected
                  ? Border.all(color: Colors.black, width: 1)
                  : null,
            ),
          ),
          Text(colorText),
        ],
      ),
    );
  }
}
