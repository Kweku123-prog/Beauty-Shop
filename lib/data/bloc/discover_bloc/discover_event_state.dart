part of 'discover_event_bloc.dart';


abstract class DiscoverState {}

class DiscoverLoading extends DiscoverState {}
class DiscoverLoaded extends DiscoverState {
  final List<Professional> professionals;
  DiscoverLoaded(this.professionals);
}
class DiscoverError extends DiscoverState {
  final String message;
  DiscoverError(this.message);
}
class DiscoverEmpty extends DiscoverState {}