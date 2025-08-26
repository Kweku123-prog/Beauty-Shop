part of 'filter_bloc.dart';



class FilterState extends Equatable {
  final String category;
  final double maxPrice;
  final String travelMode;

  const FilterState({
    this.category = 'All',
    this.maxPrice = 1000,
    this.travelMode = 'Any',
  });

  FilterState copyWith({
    String? category,
    double? maxPrice,
    String? travelMode,
  }) {
    return FilterState(
      category: category ?? this.category,
      maxPrice: maxPrice ?? this.maxPrice,
      travelMode: travelMode ?? this.travelMode,
    );
  }

  @override
  List<Object?> get props => [category, maxPrice, travelMode];
}
