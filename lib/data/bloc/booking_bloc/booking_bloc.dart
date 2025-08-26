import 'dart:developer';

import 'package:beauty/data/models/Professional.dart';
import 'package:beauty/data/models/ServiceModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SelectServiceAndTime>((event, emit) {
      emit(BookingReview(event.pro, event.service, event.timeSlot));
    });

    on<SubmitBooking>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(BookingSuccess());
    });
  }
}

