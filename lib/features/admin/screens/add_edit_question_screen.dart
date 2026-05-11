import 'package:flutter/material.dart';

class AddEditQuestionScreen extends StatelessWidget {
  const AddEditQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: 'Question')),
          ],
        ),
      ),
    );
  }
}