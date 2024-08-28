// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArticleModel {
  final String title;
  final String icon;
  final String text;
  const ArticleModel({
    required this.title,
    required this.icon,
    required this.text,
  });
  List<String> get images {
    final name = icon.split(".").first.replaceAll("icons", "images");
    return List.generate(4, (index) => "${name}_${index+1}.png");
  }
}
