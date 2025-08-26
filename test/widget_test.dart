import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'mocks/mock_discover_bloc.dart';

void main() {
  late MockDiscoverEventBloc mockBloc;

  setUp(() {
    mockBloc = MockDiscoverEventBloc();
    registerFallbackValue(FakeDiscoverState());
    registerFallbackValue(FakeDiscoverEvent());
  });

  test("Mocked bloc emits loaded state", () {
    whenListen(
      mockBloc,
      Stream.fromIterable([DiscoverLoaded([])]),
      initialState: DiscoverLoading(),
    );

    expectLater(
      mockBloc.stream,
      emitsInOrder([isA<DiscoverLoaded>()]),
    );
  });
}
