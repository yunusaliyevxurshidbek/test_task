import 'package:equatable/equatable.dart';

import '../../core/utils/date_utils.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class CalendarDataLoaded extends HomeState {
  final DateTime focusedDay;
  final DateTime? selectedDay;

  final List<DateTime> specialDays;
  final List<DateTime> pinkDays;

  CalendarDataLoaded({
    required this.focusedDay,
    this.selectedDay,
    this.specialDays = const [],
    this.pinkDays = const [],
  });

  String get formattedDate => getFormattedDate(focusedDay);
  String get month => getMonth(focusedDay);

  @override
  List<Object?> get props => [focusedDay, selectedDay, specialDays, pinkDays];
}
