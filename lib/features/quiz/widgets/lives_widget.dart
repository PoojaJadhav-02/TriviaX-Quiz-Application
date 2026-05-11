import 'package:flutter/material.dart';

class LivesWidget extends StatelessWidget {
  final int lives;

  const LivesWidget({
    super.key,
    required this.lives,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        lives,
            (index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}