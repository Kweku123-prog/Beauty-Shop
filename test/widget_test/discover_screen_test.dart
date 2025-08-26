import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'package:beauty/data/models/Professional.dart';
import 'package:beauty/data/models/ServiceModel.dart';
import 'package:beauty/features/pages/discover_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_discover_bloc.dart';

void main() {
  late MockDiscoverEventBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeDiscoverEvent());
    registerFallbackValue(FakeDiscoverState());
  });

  setUp(() {
    mockBloc = MockDiscoverEventBloc();
  });

testWidgets("shows professional cards when state is DiscoverLoaded",
    (WidgetTester tester) async {
  // fake professionals
  final fakePros = [
    Professional(
      id: 1,
      name: "Alice Stylist",
      category: "Hair",
      minPrice: 30,
      travelMode: "Home Service",
      services: [
        ServiceDataModel(id: 1, name: 'Baber', duration: 20, price: 10),
      ],
    ),
    Professional(
      id: 2,
      name: "Bob Barber",
      category: "Barber",
      minPrice: 50,
      travelMode: "In-Shop",
      services: [
        ServiceDataModel(id: 1, name: 'Baber', duration: 20, price: 10),
      ],
    ),
  ];

  // stub bloc
  when(() => mockBloc.state).thenReturn(DiscoverLoaded(fakePros));
  whenListen(
    mockBloc,
    Stream.fromIterable([DiscoverLoaded(fakePros)]),
    initialState: DiscoverLoaded(fakePros),
  );

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<DiscoverEventBloc>.value(
        value: mockBloc,
        child: const DiscoverScreen(),
      ),
    ),
  );

  // pump so the UI rebuilds after stream emits
  await tester.pump();

  // Verify cards are displayed
  expect(find.text("Alice Stylist"), findsOneWidget);
  expect(find.text("Bob Barber"), findsOneWidget);
  expect(find.byType(Card), findsNWidgets(2));
});

}
