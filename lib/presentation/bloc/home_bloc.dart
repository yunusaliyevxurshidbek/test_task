import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/presentation/bloc/home_event.dart';
import 'package:test_task/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {

    on<LoadCalendarData>((event, emit) {
      final DateTime initialDate = DateTime.now();
      emit(CalendarDataLoaded(
        focusedDay: initialDate,
        selectedDay: null,
      ));
    });

    on<SelectDay>((event, emit) {
      emit(CalendarDataLoaded(
        focusedDay: event.focusedDay,
        selectedDay: event.selectedDay,
      ));
    });
  }
}
