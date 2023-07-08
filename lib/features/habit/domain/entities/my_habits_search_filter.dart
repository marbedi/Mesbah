class MyHabitsSearchFilterEntity {
  final List<String> selectedCategory;
  final int selectedStatus;
  final String? searchText;
  MyHabitsSearchFilterEntity({
    this.selectedCategory = const [],
    this.selectedStatus = 0,
    this.searchText,
  });
  bool get hasFilter {
    return selectedCategory.isNotEmpty || selectedStatus != 0;
  }

  MyHabitsSearchFilterEntity copyWith(
      {List<String>? selectedCategory,
      int? selectedStatus,
      String? searchText}) {
    return MyHabitsSearchFilterEntity(
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedStatus: selectedStatus ?? this.selectedStatus,
        searchText: searchText ?? this.searchText);
  }
}
