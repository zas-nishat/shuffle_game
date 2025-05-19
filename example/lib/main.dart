import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuffle_game/model/model.dart';
import 'package:shuffle_game/widget/ShuffleGameWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShuffleGameWidget(
          questions: [
            ShuffleQuestion(answer: 'apple is love', hint: 'A fruit'),
            ShuffleQuestion(answer: 'book', hint: 'Used to read'),
          ],
        ),
      ),
    );
  }
}
