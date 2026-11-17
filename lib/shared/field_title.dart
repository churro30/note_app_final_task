import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(title),
      ),
    );
  }
}
