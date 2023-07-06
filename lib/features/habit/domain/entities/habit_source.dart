class HabitSource {
  final String link;
  final HabitSourceTypes type;
  final String title;
  final String desc;

  final String categoryId;

  HabitSource(
      {required this.link,
      required this.type,
      required this.desc,
      required this.title,
      required this.categoryId});
}

enum HabitSourceTypes { book, site, software }
