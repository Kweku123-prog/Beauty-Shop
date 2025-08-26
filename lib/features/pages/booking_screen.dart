import 'package:beauty/data/models/Professional.dart' show Professional;
import 'package:beauty/data/models/ServiceModel.dart';
import 'package:beauty/data/bloc/booking_bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class BookingScreen extends StatelessWidget {
  final Professional pro;
  final ServiceDataModel service;

  const BookingScreen({super.key, required this.pro, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Select Time")),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Booking successful 🎉")),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is BookingInitial) {
              return ListView(
                children: ["9:00 AM", "11:00 AM", "2:00 PM", "5:00 PM"]
                    .map((slot) => ListTile(
                          title: Text(slot),
                          onTap: () {
                            context.read<BookingBloc>().add(
                                  SelectServiceAndTime(pro, service, slot),
                                );
                          },
                        ))
                    .toList(),
              );
            } else if (state is BookingReview) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(service.name),
                        subtitle: Text(
                            "${service.duration} min • \$${service.price}"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Professional: ${pro.name}"),
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
    );
  }
}
