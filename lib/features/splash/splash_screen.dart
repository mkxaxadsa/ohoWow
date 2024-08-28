import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/features/home/home_screen.dart';

import '../../app/global_navigator/global_navigator.dart';
import '../../core/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  int progress = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
          if (progress != 100) {
            setState(() {
              progress++;
            });
            return;
          }
          GlobalNavigator.pushAndRemoveUntil(context, page: const HomeScreen());
          timer.cancel();
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo,
              width: 140,
            ).paddingOnly(bottom: 30),
            SizedBox(
              width: 120,
              height: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.14),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF1B1931),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (progress > 0)
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1246F),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ).expanded(flex: progress),
                          if (progress < 100)
                            Spacer(
                              flex: 100 - progress,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
