import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text('TriviaX')
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.quiz, arguments: 'easy');
                },
                child: const Text('Easy Quiz'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.quiz, arguments: 'medium');
                },
                child: const Text('Medium Quiz'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.quiz, arguments: 'hard');
                },
                child: const Text('Hard Quiz'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.admin);
                },
                child: const Text('Admin Panel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
