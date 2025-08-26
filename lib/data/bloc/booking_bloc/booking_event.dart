part of 'booking_bloc.dart';

abstract class BookingEvent {}

class SelectServiceAndTime extends BookingEvent {
  final Professional pro;
  final ServiceDataModel service;
  final String timeSlot;
  SelectServiceAndTime(this.pro, this.service, this.timeSlot);
}

class SubmitBooking extends BookingEvent {}