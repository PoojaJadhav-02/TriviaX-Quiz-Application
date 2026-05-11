import 'dart:math';

class Helpers {
  static List<String> shuffleAnswers(
      List<String> answers,
      ) {
    answers.shuffle(Random());
    return answers;
  }
}