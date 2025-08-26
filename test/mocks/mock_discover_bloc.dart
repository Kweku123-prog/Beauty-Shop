import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mock the Bloc
class MockDiscoverEventBloc extends Mock implements DiscoverEventBloc {}

// Fake states to use with whenListen
class FakeDiscoverState extends Fake implements DiscoverState {}
class FakeDiscoverEvent extends Fake implements DiscoverEvent {}
