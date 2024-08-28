// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/core/extensions/expanded_ext_on_widget.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';

import 'package:ojo/data/models/article_model.dart';

class DetailArticleScreen extends StatefulWidget {
  const DetailArticleScreen({
    Key? key,
    required this.article,
  }) : super(key: key);
  final ArticleModel article;
  @override
  State<DetailArticleScreen> createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  int currentImgIndex = 0;

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
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ).expanded(),
                ],
              ).paddingOnly(bottom: 10),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 14),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      widget.article.images[currentImgIndex],
                      width: double.maxFinite,
                      height: 260,
                      fit: BoxFit.fill,
                    ),
                  ).paddingOnly(bottom: 30),
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      color: Color(0xFFF1246F),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ).paddingOnly(bottom: 24),
                  Text(
                    widget.article.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ).paddingOnly(bottom: 48),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.31,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.article.images.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == currentImgIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentImgIndex = index;
                          });
                        },
                        child: Container(
                          width: 166,
                          height: 126,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.article.images[index]),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: isSelected
                                  ? const BorderSide(
                                      width: 4,
                                      color: Color(0xFFF1246F),
                                    )
                                  : BorderSide.none,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            shadows: isSelected
                                ? [
                                    const BoxShadow(
                                      color: Color(0x7AF1246F),
                                      blurRadius: 9,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      );
                    },
                  ).paddingOnly(bottom: 20),
                ],
              ).expanded(),
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
