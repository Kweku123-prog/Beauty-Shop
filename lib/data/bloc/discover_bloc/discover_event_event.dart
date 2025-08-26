part of 'discover_event_bloc.dart';



abstract class DiscoverEvent {}

class LoadProfessionals extends DiscoverEvent {}
class ApplyFilters extends DiscoverEvent {
  final String? category;
  final double? maxPrice;
  final String? travelMode;

  ApplyFilters({this.category, this.maxPrice, this.travelMode});
}

