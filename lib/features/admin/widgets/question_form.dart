import 'package:flutter/material.dart';

class QuestionForm extends StatelessWidget {
  const QuestionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter Question',
          ),
        ),
      ],
    );
  }
}