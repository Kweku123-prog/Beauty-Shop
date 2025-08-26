import 'package:beauty/data/models/Professional.dart';
import 'package:beauty/data/models/ServiceModel.dart';
import 'package:beauty/data/bloc/booking_bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class FakeBookingEvent extends Fake implements BookingEvent {}
class FakeBookingState extends Fake implements BookingState {}
class MockBookingBloc extends Mock implements BookingBloc {}

void main() {

    setUpAll(() {
    registerFallbackValue(FakeBookingEvent());
    registerFallbackValue(FakeBookingState());
  });
  late MockBookingBloc mockBloc;
  late Professional pro;
  late ServiceDataModel service;

  setUp(() {
    mockBloc = MockBookingBloc();

    pro = Professional(
      id: 1,
      name: "Alice Stylist",
      category: "Hair",
      minPrice: 30,
      travelMode: "Home Service",
      services: [],
    );

    service = ServiceDataModel(
      id: 1,
      name: "Haircut",
      duration: 45,
      price: 25,
    );
  });

  testWidgets("renders BookingReview with service, pro, and time slot",
      (WidgetTester tester) async {
    // Stub bloc
    when(() => mockBloc.state)
        .thenReturn(BookingReview(pro, service, "10:00 AM"));
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(BookingReview(pro, service, "10:00 AM")));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<BookingBloc>.value(
          value: mockBloc,
          child: Builder(
            builder: (context) {
              final state = context.watch<BookingBloc>().state;
              if (state is BookingReview) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(state.service.name),
                          subtitle: Text(
                              "${state.service.duration} min • \$${state.service.price}"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("Professional: ${state.pro.name}"),
                      Text("Time Slot: ${state.timeSlot}"),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          context.read<BookingBloc>().add(SubmitBooking());
                        },
                        child: const Text("Submit Booking"),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    await tester.pump();

    // ✅ Check service info
    expect(find.text("Haircut"), findsOneWidget);
    expect(find.text("45 min • \$25.0"), findsOneWidget);

    // ✅ Check professional name and time slot
    expect(find.text("Professional: Alice Stylist"), findsOneWidget);
    expect(find.text("Time Slot: 10:00 AM"), findsOneWidget);

    // ✅ Check button exists
    expect(find.text("Submit Booking"), findsOneWidget);

    // ✅ Tap button and verify event added
    await tester.tap(find.text("Submit Booking"));
    verify(() => mockBloc.add(any(that: isA<SubmitBooking>()))).called(1);
  });
}
