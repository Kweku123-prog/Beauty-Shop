import 'dart:convert';
import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'package:beauty/data/models/Professional.dart';
import 'package:beauty/data/models/ServiceModel.dart';
import 'package:beauty/data/repository/ProfessionalRepository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockProfessionalRepository extends Mock implements ProfessionalRepository {}

void main() {
  late MockProfessionalRepository mockRepository;
  late DiscoverEventBloc bloc;

  // --- your JSON test data ---
  const jsonData = '''
  [
    {
      "id": 1,
      "name": "Ama the Hair Stylist",
      "category": "Hair",
      "minPrice": 50,
      "travelMode": "Home Service",
      "services": [
        { "id": 1, "name": "Braids", "duration": 60, "price": 100 },
        { "id": 2, "name": "Haircut", "duration": 30, "price": 50 }
      ]
    },
    {
      "id": 2,
      "name": "Kwame the Barber",
      "category": "Barber",
      "minPrice": 30,
      "travelMode": "In-Shop",
      "services": [
        { "id": 3, "name": "Fade Cut", "duration": 25, "price": 30 },
        { "id": 4, "name": "Beard Trim", "duration": 15, "price": 20 }
      ]
    }
  ]
  ''';

  late List<Professional> pros;

  setUp(() {
    final parsed = jsonDecode(jsonData) as List;
    pros = parsed.map((e) => Professional.fromJson(e)).toList();

    mockRepository = MockProfessionalRepository();
    bloc = DiscoverEventBloc(mockRepository);
  });

  tearDown(() => bloc.close());

  group("DiscoverEventBloc with real JSON", () {
    blocTest<DiscoverEventBloc, DiscoverState>(
      "emits [DiscoverLoading, DiscoverLoaded] when LoadProfessionals loads mock data",
      build: () {
        when(() => mockRepository.fetchProfessionals())
            .thenAnswer((_) async => pros);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProfessionals()),
      expect: () => [
        isA<DiscoverLoading>(),
        isA<DiscoverLoaded>().having((s) => s.professionals.length, "length", 2),
      ],
    );

    blocTest<DiscoverEventBloc, DiscoverState>(
      "applies filters correctly (Hair + Home Service + maxPrice 60)",
      build: () {
        when(() => mockRepository.fetchProfessionals())
            .thenAnswer((_) async => pros);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(LoadProfessionals());
        await Future.delayed(Duration.zero);
        bloc.add(ApplyFilters(category: "Hair", maxPrice: 60, travelMode: "Home Service"));
      },
      expect: () => [
        isA<DiscoverLoading>(),
        isA<DiscoverLoaded>(), // after loading
        isA<DiscoverLoaded>().having(
          (s) => s.professionals.first.name,
          "name",
          "Ama the Hair Stylist",
        ),
      ],
    );
  });
}
