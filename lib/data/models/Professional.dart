





import 'package:beauty/data/models/ServiceModel.dart';

class Professional {
  final int id;
  final String name;
  final String category;
  final double minPrice;
  final String travelMode;
  final List<ServiceDataModel> services;

  Professional({
    required this.id,
    required this.name,
    required this.category,
    required this.minPrice,
    required this.travelMode,
    required this.services,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      minPrice: (json['minPrice'] as num).toDouble(),
      travelMode: json['travelMode'],
      services: (json['services'] as List)
          .map((s) => ServiceDataModel.fromJson(s))
          .toList(),
    );
  }
}
