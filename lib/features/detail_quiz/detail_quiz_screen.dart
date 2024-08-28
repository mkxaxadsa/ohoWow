// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ojo/app/global_navigator/global_navigator.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/constants/app_images.dart';
import 'package:ojo/core/extensions/align_ext_on_widget.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/core/ui_components/dialogs/wrong.dart';
import 'package:ojo/data/models/question_model.dart';

import 'package:ojo/data/models/quiz_model.dart';
import 'package:ojo/features/home/home_screen.dart';

class DetailQuizScreen extends StatefulWidget {
  const DetailQuizScreen({
    Key? key,
    required this.quiz,
  }) : super(key: key);
  final Quiz quiz;
  @override
  State<DetailQuizScreen> createState() => _DetailQuizScreenState();
}

class _DetailQuizScreenState extends State<DetailQuizScreen> {
  late final List<Question> questions;

  int currentSeconds = 120;

  Timer? timer;

  int currentQuestionIndex = 0;

  @override
  void initState() {
    questions = widget.quiz.questions;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        setState(() {
          currentSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int currentAnswerIndex = -1;

  void answerToQuestion(int index) {
    if (currentAnswerIndex != -1) return;
    setState(() {
      currentAnswerIndex = index;
    });
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        currentAnswerIndex = -1;
      });
      if (index != 1) {
        showWrongDialog(context);
        return;
      }
      if (currentQuestionIndex == questions.length - 1) {
        GlobalNavigator.pushAndRemoveUntil(context, page: const HomeScreen());
        return;
      }
      setState(() {
        currentQuestionIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
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
                        Text(
                          widget.quiz.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 117,
                          height: 32,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFBE9EFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppIcons.check,
                                width: 16,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                '2 players',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 14),
                    ListView(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 260,
                          padding: const EdgeInsets.all(14),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F243F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFEB3C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Player 1',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Builder(
                                      builder: (context) {
                                        final minutes = currentSeconds ~/ 60;
                                        final seconds =
                                            currentSeconds - (minutes * 60);
                                        return Text(
                                          '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Question',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${currentQuestionIndex + 1} / ${questions.length}',
                                    style: const TextStyle(
                                      color: Color(0xFFF1246F),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ).paddingSymetric(vertical: 14),
                              Text(
                                currentQuestion.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                                  .paddingSymetric(horizontal: 10)
                                  .align()
                                  .expanded(),
                            ],
                          ),
                        ).paddingOnly(bottom: 24),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.66,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                          ),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: currentQuestion.variants.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                answerToQuestion(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: ShapeDecoration(
                                  color: currentAnswerIndex == -1 ||
                                          currentAnswerIndex != index
                                      ? const Color(0xFF1F243F)
                                      : currentAnswerIndex == 1
                                          ? const Color(0xFF4BB030)
                                          : const Color(0xFFF1246F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF1246F),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      currentQuestion.variants[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ).align(),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ).expanded(),
                  ],
                ).paddingSymetric(horizontal: 24, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
