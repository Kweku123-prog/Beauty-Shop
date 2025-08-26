part of 'booking_bloc.dart';


// final class BookingInitial extends BookingState {}
abstract class BookingState {}

class BookingInitial extends BookingState {}
class BookingReview extends BookingState {
  final Professional pro;
  final ServiceDataModel service;
  final String timeSlot;
  BookingReview(this.pro, this.service, this.timeSlot);
}
class BookingSuccess extends BookingState {}
