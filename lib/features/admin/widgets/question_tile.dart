import 'package:flutter/material.dart';

class QuestionTile extends StatelessWidget {
  final String question;

  const QuestionTile({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(question),
      trailing: const Icon(Icons.edit),
    );
  }
}