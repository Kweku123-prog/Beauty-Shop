import 'package:beauty/features/pages/booking_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/Professional.dart' show Professional;



class ProfessionalDetailsScreen extends StatelessWidget {
  final Professional pro;
  const ProfessionalDetailsScreen({super.key, required this.pro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pro.name)),
      body: ListView(
        children: pro.services.map((service) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(service.name),
              subtitle: Text("${service.duration} min • \$${service.price}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(pro: pro, service: service),
                    ),
                  );
                },
                child: const Text("Select Time"),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
