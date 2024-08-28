import 'package:flutter/material.dart';
import 'package:ojo/app/global_navigator/global_navigator.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/constants/app_images.dart';
import 'package:ojo/core/data/articles.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/core/ui_components/dialogs/reward_dialog.dart';
import 'package:ojo/data/helpers/hive_helper.dart';
import 'package:ojo/features/home/articles/articles_screen.dart';
import 'package:ojo/features/home/components/interesting_item.dart';
import 'package:ojo/features/new_quiz/new_quiz_screen.dart';
import 'package:ojo/features/quizzes/quizzes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (HiveHelper.isDailyRewardAvailable) {
        showRewardDialog(context).then((value) {
          setState(() {});
        });
      }
    });
    super.initState();
  }

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
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.logo2,
                            height: 32,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color:
                                  Colors.black.withOpacity(0.800000011920929),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppImages.coin,
                                  width: 20,
                                ).paddingOnly(right: 4),
                                Text(
                                  '${HiveHelper.coins}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ).paddingOnly(right: 10),
                        ],
                      ).paddingOnly(bottom: 24),
                      GestureDetector(
                        onTap: () {
                          GlobalNavigator.push(context,
                              page: const QuizzesScreen());
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 250,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    AppImages.homeHeaderImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 15,
                                  child: Container(
                                    width: 74,
                                    height: 37,
                                    decoration: ShapeDecoration(
                                      color: Colors.black
                                          .withOpacity(0.699999988079071),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Quiz',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).paddingOnly(bottom: 38),
                      ),
                      GestureDetector(
                        onTap: () {
                          GlobalNavigator.push(context,
                              page: const NewQuizScreen());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: 64,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1E233F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Create Quiz',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ).expanded(),
                              Image.asset(
                                AppIcons.addCircle,
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 40),
                      Row(
                        children: [
                          const Text(
                            'Interesting 🔥 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              GlobalNavigator.push(context,
                                  page: const ArticlesScreen());
                            },
                            child: Container(
                              width: 80,
                              height: 29,
                              decoration: ShapeDecoration(
                                color: const Color(0x3DF1246F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Color(0xFFF1246F),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          mainAxisExtent: 200,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return InterestingItem(item: articles[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
