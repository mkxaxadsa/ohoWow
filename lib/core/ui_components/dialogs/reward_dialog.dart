import 'package:flutter/material.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/constants/app_images.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/core/utils/get_random_int_in_range.dart';
import 'package:ojo/data/helpers/hive_helper.dart';

Future<void> showRewardDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 35),
          child: RewardDialog(),
        );
      },
      barrierColor: Colors.black12);
}

class RewardDialog extends StatefulWidget {
  const RewardDialog({super.key});

  @override
  State<RewardDialog> createState() => _RewardDialogState();
}

class _RewardDialogState extends State<RewardDialog> {
  final rewardCoins = getRandomIntInRange();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF1F243F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0xE5000000),
                  blurRadius: 0,
                  offset: Offset(0, 40),
                  spreadRadius: 300,
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 108.03,
                  height: 106.49,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppImages.coin),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: isSelected
                        ? [
                            const BoxShadow(
                              color: Color(0xFFFFEB3B),
                              blurRadius: 54,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ]
                        : null,
                  ),
                ).paddingOnly(bottom: 30),
                const Text(
                  'Daily Reward',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ).paddingOnly(bottom: 10),
                 Text(
                 isSelected ? 'Congratulations! You have received:' : "Choose one of the cards and find out your reward",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFBE9EFA),
                    fontFamily: 'Inter',
                  ),
                ).paddingOnly(bottom: 30),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.800000011920929),
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
                          '$rewardCoins',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                isSelected = true;
                              },
                            );
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(14),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF1246F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              AppIcons.gift,
                              width: 20,
                            ),
                          ),
                        ).paddingSymetric(horizontal: 7);
                      },
                    ),
                  )
              ],
            ),
          ).paddingOnly(bottom: 24),
          if (isSelected)
            GestureDetector(
              onTap: () {
                HiveHelper.receiveReward(rewardCoins).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Container(
                width: 200,
                height: 52,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF1246F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Receive',
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
      );
    });
  }
}
