import 'package:flutter/material.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/data/articles.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';
import 'package:ojo/features/home/components/interesting_item.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      width: 80.50,
                      height: 39,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF1246F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppIcons.chevronLeft,
                            width: 8,
                          ).paddingOnly(right: 10),
                          const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).paddingOnly(right: 14),
                  const Text(
                    'Interesting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ).expanded(),
                ],
              ).paddingOnly(bottom: 10),
              GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 14),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 200,
                ),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return InterestingItem(item: articles[index]);
                },
              ).expanded(),
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
