import 'package:beauty/data/models/Professional.dart';
import 'package:beauty/data/repository/ProfessionalRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'discover_event_event.dart';
part 'discover_event_state.dart';

class DiscoverEventBloc extends Bloc<DiscoverEvent, DiscoverState> {
    final ProfessionalRepository repository;
  List<Professional> _allPros = [];
  // DiscoverEventBloc() : super(DiscoverEventInitial()) {
  //   on<DiscoverEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

    DiscoverEventBloc(this.repository) : super(DiscoverLoading()) {
    on<LoadProfessionals>(_onLoadProfessionals);
    on<ApplyFilters>(_onApplyFilters);
  }


    Future<void> _onLoadProfessionals(
    LoadProfessionals event,
    Emitter<DiscoverState> emit,
  ) async {
    emit(DiscoverLoading());
    try {
      _allPros = await repository.fetchProfessionals();
      if (_allPros.isEmpty) {
        emit(DiscoverEmpty());
      } else {
        emit(DiscoverLoaded(_allPros));
      }
    } catch (e) {
      emit(DiscoverError("Failed to load professionals"));
    }
  }

//Apply filters to the loaded professionals
    void _onApplyFilters(
    ApplyFilters event,
    Emitter<DiscoverState> emit,
  ) {
   var filtered = _allPros;

      if (event.category != null && event.category != 'All') {
        filtered = filtered
            .where((p) => p.category == event.category)
            .toList();
      }

      if (event.maxPrice != null) {
        filtered =
            filtered.where((p) => p.minPrice <= event.maxPrice!).toList();
      }

      if (event.travelMode != null && event.travelMode != 'Any') {
        filtered = filtered
            .where((p) => p.travelMode == event.travelMode)
            .toList();
      }

      if (filtered.isEmpty) {
        emit(DiscoverEmpty());
      } else {
        emit(DiscoverLoaded(filtered));
      }
  }


}


