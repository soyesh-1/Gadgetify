import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  // Holds the index of the selected bottom navigation tab.
  final int selectedIndex;
  // In the future, these lists will be populated from a UseCase.
  // For now, we'll keep the hardcoded data here.
  final List<Map<String, dynamic>> categories;
  final List<Map<String, String>> specialForYouProducts;
  final List<Map<String, String>> popularProducts;
  final bool isLoading;

  const HomeState({
    this.selectedIndex = 0,
    this.categories = const [],
    this.specialForYouProducts = const [],
    this.popularProducts = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    int? selectedIndex,
    List<Map<String, dynamic>>? categories,
    List<Map<String, String>>? specialForYouProducts,
    List<Map<String, String>>? popularProducts,
    bool? isLoading,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categories: categories ?? this.categories,
      specialForYouProducts:
          specialForYouProducts ?? this.specialForYouProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
    selectedIndex,
    categories,
    specialForYouProducts,
    popularProducts,
    isLoading,
  ];
}
