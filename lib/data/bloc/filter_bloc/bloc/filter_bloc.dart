
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState()) {
     on<CategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category));
    });
        on<MaxPriceChanged>((event, emit) {
      emit(state.copyWith(maxPrice: event.price));
    });

    on<TravelModeChanged>((event, emit) {
      emit(state.copyWith(travelMode: event.mode));
    });

  }
}



