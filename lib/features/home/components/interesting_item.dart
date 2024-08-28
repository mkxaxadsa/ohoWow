// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ojo/app/global_navigator/global_navigator.dart';
import 'package:ojo/core/extensions/align_ext_on_widget.dart';

import 'package:ojo/data/models/article_model.dart';
import 'package:ojo/features/home/articles/detail_article/detail_article_screen.dart';

class InterestingItem extends StatelessWidget {
  const InterestingItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ArticleModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalNavigator.push(context, page: DetailArticleScreen(article: item));
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
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Image.asset(
              item.icon,
              width: 100,
              height: 100,
            ).align(Alignment.centerRight),
          ],
        ),
      ),
    );
  }
}
