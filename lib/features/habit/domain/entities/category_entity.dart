class CategoryEntity {
  final String id;
  final String name;
  final List<CategoryEntity>? subCategory;
  final String? icon;

  CategoryEntity(
      {required this.id, required this.name, this.subCategory, this.icon});
}
