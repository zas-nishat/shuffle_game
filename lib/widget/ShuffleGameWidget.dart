import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ShuffleGameController.dart';
import '../model/model.dart';

class ShuffleGameWidget extends StatelessWidget {
  final List<ShuffleQuestion> questions;

  ShuffleGameWidget({super.key, required this.questions}) {
    final controller = Get.put(ShuffleGameController());
    controller.loadQuestions(questions);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShuffleGameController>();

    return Obx(() {
      if (controller.questions.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final word = controller.questions[controller.currentIndex.value].answer;
      final hint = controller.questions[controller.currentIndex.value].hint;
      final letterIndices = controller.getShuffledIndices();
      final wordLetters = word.split('');

      return Column(
        children: [
          Text("Hint: $hint"),
          Wrap(
            children: letterIndices
                .where((i) => !controller.usedLetterIndices.contains(i))
                .map((index) => GestureDetector(
              onTap: () => controller.onLetterTap(wordLetters[index], index),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(wordLetters[index]),
                ),
              ),
            ))
                .toList(),
          ),
          Wrap(
            children: List.generate(
              word.length,
                  (i) => GestureDetector(
                onTap: () => controller.onAnswerLetterTap(i),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      i < controller.userAnswer.value.length
                          ? controller.userAnswer.value[i]
                          : '_',
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: controller.onSubmit,
            child: const Text("Submit"),
          ),
          TextButton(
            onPressed: controller.onSkip,
            child: const Text("Skip"),
          ),
          Obx(() => Text(controller.resultMessage.value)),
        ],
      );
    });
  }
}
