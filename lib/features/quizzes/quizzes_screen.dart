import 'package:flutter/material.dart';
import 'package:ojo/app/global_navigator/global_navigator.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/constants/app_images.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/data/helpers/hive_helper.dart';
import 'package:ojo/features/detail_quiz/detail_quiz_screen.dart';

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final quizzes = HiveHelper.quizzes;

  @override
  Widget build(BuildContext context) {
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
                            'Choose a quiz',
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
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                        ),
                        itemCount: quizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = quizzes[index];
                          return GestureDetector(
                            onTap: () {
                              GlobalNavigator.push(context, page: DetailQuizScreen(quiz: quiz));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF1F243F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quiz #${index + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFFF1246F),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${quiz.questions.length} questions',
                                    style: const TextStyle(
                                      color: Color(0xFFFFEB3B),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ).paddingOnly(bottom: 14),
                                  Text(
                                    quiz.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ).expanded(),
                    ],
                  ).paddingSymetric(horizontal: 24, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
