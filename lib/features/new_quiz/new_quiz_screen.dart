import 'package:flutter/material.dart';
import 'package:ojo/app/global_navigator/global_navigator.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/constants/app_images.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/hidekeyboard_ext_on_context.dart';
import 'package:ojo/core/extensions/opacity_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/data/helpers/hive_helper.dart';
import 'package:ojo/data/models/question_model.dart';
import 'package:ojo/data/models/quiz_model.dart';
import 'package:ojo/features/home/home_screen.dart';

class NewQuizScreen extends StatefulWidget {
  const NewQuizScreen({super.key});

  @override
  State<NewQuizScreen> createState() => _NewQuizScreenState();
}

class _NewQuizScreenState extends State<NewQuizScreen> {
  List<Question> questions = [Question.empty()];

  @override
  Widget build(BuildContext context) {
    final isQuestionsFilled = questions.every(
      (element) => element.isValidated,
    );
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Image.asset(
                AppImages.header,
                width: double.maxFinite,
                height: 300,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: SafeArea(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF1246F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppIcons.back,
                                  width: 16,
                                ),
                              ),
                            ).paddingOnly(right: 14),
                            const Text(
                              'New Quiz',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ).paddingOnly(bottom: 14),
                        ListView(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          children: [
                            ...List.generate(questions.length, (index) {
                              return Column(
                                children: [
                                  _itemBlock(
                                    title: "Question",
                                    rightTitle: "#${index + 1}",
                                    hintText: "Enter a question",
                                    linesCount: 3,
                                    onChange: (value) {
                                      setState(() {
                                        questions[index] = questions[index]
                                            .copyWith(question: value.trim());
                                      });
                                    },
                                  ).paddingOnly(bottom: 14),
                                  _itemBlock(
                                    title: "Answer",
                                    rightTitle: "A",
                                    onChange: (value) {
                                      setState(() {
                                        questions[index] = questions[index]
                                            .copyWith(answerA: value.trim());
                                      });
                                    },
                                  ).paddingOnly(bottom: 14),
                                  _itemBlock(
                                    title: "Answer",
                                    rightTitle: "B",
                                    onChange: (value) {
                                      setState(() {
                                        questions[index] = questions[index]
                                            .copyWith(answerB: value.trim());
                                      });
                                    },
                                  ).paddingOnly(bottom: 14),
                                  _itemBlock(
                                    title: "Answer",
                                    rightTitle: "C",
                                    onChange: (value) {
                                      setState(() {
                                        questions[index] = questions[index]
                                            .copyWith(answerC: value.trim());
                                      });
                                    },
                                  ).paddingOnly(bottom: 14),
                                  _itemBlock(
                                    title: "Answer",
                                    rightTitle: "D",
                                    onChange: (value) {
                                      setState(() {
                                        questions[index] = questions[index]
                                            .copyWith(answerD: value.trim());
                                      });
                                    },
                                  ).paddingOnly(bottom: 14),
                                ],
                              ).paddingOnly(top: index == 0 ? 0 : 40);
                            }),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  questions.add(Question.empty());
                                });
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF1246F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  '+ Add New Question',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).expanded(),
                        GestureDetector(
                          onTap: () {
                            if (!isQuestionsFilled) return;
                            HiveHelper.saveQuiz(Quiz(questions: questions))
                                .then(
                              (_) {
                                GlobalNavigator.pushAndRemoveUntil(context,
                                    page: const HomeScreen());
                              },
                            );
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF4BB030),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              '+ Add New Question',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ).opacity(isQuestionsFilled ? 1 : .5),
                        ).paddingOnly(top: 10),
                      ],
                    ).paddingSymetric(horizontal: 24, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBlock({
    required String title,
    required String rightTitle,
    required void Function(String value) onChange,
    String hintText = "Enter the answer to the question",
    int linesCount = 1,
  }) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        color: const Color(0xFF1F243F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                rightTitle,
                style: const TextStyle(
                  color: Color(0xFFF1246F),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ).paddingOnly(bottom: 12),
          TextField(
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            onChanged: onChange,
            minLines: linesCount,
            maxLines: linesCount,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14),
              filled: true,
              fillColor: const Color(0xFF33395B),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(.5),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
