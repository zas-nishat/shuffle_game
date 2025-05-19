import 'dart:math';
import 'package:get/get.dart';

import '../model/model.dart';

class ShuffleGameController extends GetxController {
  RxList<ShuffleQuestion> questions = <ShuffleQuestion>[].obs;
  RxInt currentIndex = 0.obs;
  RxString userAnswer = ''.obs;
  RxString resultMessage = ''.obs;
  RxList<int> usedLetterIndices = <int>[].obs;
  RxInt correctCount = 0.obs;
  RxInt wrongCount = 0.obs;
  RxInt skippedCount = 0.obs;

  void loadQuestions(List<ShuffleQuestion> inputQuestions) {
    questions.assignAll(inputQuestions);
    questions.shuffle();
  }

  void onLetterTap(String letter, int index) {
    if (userAnswer.value.length < (questions[currentIndex.value].answer).length) {
      userAnswer.value += letter;
      usedLetterIndices.add(index);
    }
  }

  void onAnswerLetterTap(int index) {
    if (index < userAnswer.value.length) {
      final newAnswer = userAnswer.value.substring(0, index) + userAnswer.value.substring(index + 1);
      userAnswer.value = newAnswer;
      if (usedLetterIndices.isNotEmpty) {
        usedLetterIndices.removeLast();
      }
    }
  }

  void onSubmit() {
    final correct = questions[currentIndex.value].answer.toLowerCase().trim();
    final user = userAnswer.value.toLowerCase().trim();

    if (user == correct) {
      resultMessage.value = '✅ Correct!';
      correctCount.value += 1;
    } else {
      resultMessage.value = '❌ Incorrect! Correct: $correct';
      wrongCount.value += 1;
    }
  }

  void onSkip() {
    skippedCount.value += 1;
    nextQuestion();
  }

  void nextQuestion() {
    currentIndex.value = (currentIndex.value + 1) % questions.length;
    userAnswer.value = '';
    resultMessage.value = '';
    usedLetterIndices.clear();
  }

  List<int> getShuffledIndices() {
    if (questions.isEmpty) return [];
    final word = questions[currentIndex.value].answer;
    final indices = List.generate(word.length, (i) => i);
    indices.shuffle(Random());
    return indices;
  }
}
