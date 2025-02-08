class SupportData{
  String name;
  String action;
  String? title;
  String? content;

  SupportData({
    required this.name,
    required this.action,
    this.title,
    this.content
  });
}