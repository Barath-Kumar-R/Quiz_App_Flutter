import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

Quizbrain quizbrain = Quizbrain();

void main() => runApp(const Quizzz());

class Quizzz extends StatelessWidget {
  const Quizzz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: QuizApp(),
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scorekeeper = [];
  int qnumber = 0;

  void nextquestion() {
    if (qnumber > 11) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ALERT",
        desc: "The quiz is over",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "RESTART",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
      qnumber = 0;
      scorekeeper = [];
    } else if (qnumber < quizbrain.questionbank.length) {
      qnumber++;
    }
  }

  void checkanswer(bool userpickedanswer) {
    bool correctanswer = quizbrain.questionbank[qnumber].questionAns;
    if (correctanswer == userpickedanswer &&
        qnumber < quizbrain.questionbank.length - 1) {
      scorekeeper.add(
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else if (correctanswer != userpickedanswer &&
        qnumber < quizbrain.questionbank.length - 1) {
      scorekeeper.add(
        const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizbrain.questionbank[qnumber].questionText,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.green.shade800),
              onPressed: () {
                setState(
                  () {
                    nextquestion();
                    checkanswer(true);
                  },
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(
                  () {
                    nextquestion();
                    checkanswer(false);
                  },
                );
              },
              child: const Text(
                'No',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(children: scorekeeper),
      ],
    );
  }
}
