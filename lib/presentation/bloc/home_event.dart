import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCalendarData extends HomeEvent {}

class SelectDay extends HomeEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  SelectDay(this.selectedDay,this.focusedDay);

  @override
  List<Object?> get props => [selectedDay,focusedDay];
}