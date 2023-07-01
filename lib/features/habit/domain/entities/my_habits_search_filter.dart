class MyHabitsSearchFilterEntity {
  final List<int> selectedCategory;
  final int selectedStatus;

  MyHabitsSearchFilterEntity({
    this.selectedCategory = const [],
    this.selectedStatus = 0,
  });
  bool get hasFilter {
    return selectedCategory.isNotEmpty || selectedStatus != 0;
  }

  MyHabitsSearchFilterEntity copyWith({
    List<int>? selectedCategory,
    int? selectedStatus,
  }) {
    return MyHabitsSearchFilterEntity(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}
