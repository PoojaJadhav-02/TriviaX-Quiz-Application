import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../quiz/models/custom_question_model.dart';
import '../../../core/services/storage_service.dart';

class CustomQuizNotifier extends StateNotifier<List<CustomQuestionModel>> {
  CustomQuizNotifier() : super([]) {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final json = await StorageService.getCustomQuestions();
    if (json != null && json.isNotEmpty) {
      state = CustomQuestionModel.decodeList(json);
    }
  }

  Future<void> _persist() async {
    await StorageService.setCustomQuestions(
      CustomQuestionModel.encodeList(state),
    );
  }

  void addQuestion(CustomQuestionModel question) {
    state = [...state, question];
    _persist();
  }

  void updateQuestion(String id, CustomQuestionModel updated) {
    state = state.map((q) => q.id == id ? updated : q).toList();
    _persist();
  }

  void deleteQuestion(String id) {
    state = state.where((q) => q.id != id).toList();
    _persist();
  }
}

final customQuizProvider =
    StateNotifierProvider<CustomQuizNotifier, List<CustomQuestionModel>>(
  (ref) => CustomQuizNotifier(),
);
