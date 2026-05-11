import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade100,
        ),
        child: Text(title),
      ),
    );
  }
}