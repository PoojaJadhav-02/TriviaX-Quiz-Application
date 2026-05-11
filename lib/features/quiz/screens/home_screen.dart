import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//           title: const Text('TriviaX'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             spacing: 10,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.quiz, arguments: 'easy');
//                 },
//                 child: const Text('Easy Quiz'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.quiz, arguments: 'medium');
//                 },
//                 child: const Text('Medium Quiz'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.quiz, arguments: 'hard');
//                 },
//                 child: const Text('Hard Quiz'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.admin);
//                 },
//                 child: const Text('Admin Panel'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });

    Get.changeThemeMode(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: const Text('TriviaX'),

        actions: [
          IconButton(
            onPressed: toggleTheme,
            icon: Icon(
              isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            spacing: 10,

            children: [
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.quiz,
                    arguments: 'easy',
                  );
                },

                child: const Text('Easy Quiz'),
              ),

              ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.quiz,
                    arguments: 'medium',
                  );
                },

                child: const Text('Medium Quiz'),
              ),

              ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.quiz,
                    arguments: 'hard',
                  );
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