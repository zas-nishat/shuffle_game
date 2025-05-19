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

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hint: $hint",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20,),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children:
                  letterIndices
                      .where((i) => !controller.usedLetterIndices.contains(i))
                      .map(
                        (index) => GestureDetector(
                          onTap:
                              () => controller.onLetterTap(
                                wordLetters[index],
                                index,
                              ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(wordLetters[index],textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 10,),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(
                word.length,
                (i) => GestureDetector(
                  onTap: () => controller.onAnswerLetterTap(i),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        i < controller.userAnswer.value.length
                            ? controller.userAnswer.value[i]
                            : '_',
                      ),
                    ),
                  ),
                ),
              ),
            ),SizedBox(height: 40,),
            GestureDetector(
              onTap: controller.onSubmit,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.teal
                ),
                width: Get.width * 0.9,
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                  child: const Text("Submit",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15
                  ),),
                )),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: controller.onSkip,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.deepOrange
                ),
                width: Get.width * 0.9,
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                  child: const Text("Skip",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15
                  ),),
                )),
              ),
            ),
            Obx(() => Text(controller.resultMessage.value)),
          ],
        ),
      );
    });
  }
}
