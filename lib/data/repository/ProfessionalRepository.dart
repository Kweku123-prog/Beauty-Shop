import 'dart:convert';
import 'package:beauty/data/models/Professional.dart';
import 'package:flutter/services.dart';


class ProfessionalRepository {
  Future<List<Professional>> fetchProfessionals() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate loading
    final data = await rootBundle.loadString('assets/mock_pros.json');
    final list = jsonDecode(data) as List;
    return list.map((json) => Professional.fromJson(json)).toList();
  }
}
