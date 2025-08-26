part of 'filter_bloc.dart';

abstract class FilterEvent {}

class CategoryChanged extends FilterEvent {
  final String category;
  CategoryChanged(this.category);
}

class MaxPriceChanged extends FilterEvent {
  final double price;
  MaxPriceChanged(this.price);
}

class TravelModeChanged extends FilterEvent {
  final String mode;
  TravelModeChanged(this.mode);
}
