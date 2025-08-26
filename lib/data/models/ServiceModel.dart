class ServiceDataModel {
  final int id;
  final String name;
  final int duration; // in minutes
  final double price;

  ServiceDataModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceDataModel(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
