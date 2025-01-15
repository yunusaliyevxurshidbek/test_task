import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/special_day_utils.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<DateTime> specialDays;
  final List<DateTime> pinkDays;

  const CalendarWidget({
    Key? key,
    required this.focusedDay,
    this.selectedDay,
    this.specialDays = const [],
    this.pinkDays = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2020, 1, 1),
      lastDay: DateTime(2026, 1, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) =>
      selectedDay != null && isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        context
            .read<HomeBloc>()
            .add(SelectDay(selectedDay, focusedDay));
      },
      onPageChanged: (focusedDay) {
        context
            .read<HomeBloc>()
            .add(SelectDay(focusedDay, focusedDay));
      },
      calendarStyle: CalendarStyle(
        cellMargin: EdgeInsets.zero,
        defaultDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.5),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        outsideDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        outsideDaysVisible: true,
      ),
      headerVisible: false,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          bool isSpecial = isSpecialDay(day);
          bool isPink = isPinkDay(day);

          return Container(
            padding: const EdgeInsets.only(left: 5, top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 0.5,
              ),
              color: isPink
                  ? Colors.pink.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.05),
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPink ? Colors.white : null,
                  ),
                ),
                if (isSpecial)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 10,
                    ),
                    child: Image.asset(
                      'assets/images/leaf.png',
                      width: 16,
                      height: 16,
                    ),
                  ),
                if (isPink)
                  const Padding(
                    padding: EdgeInsets.only(top: 3, left: 10),
                    child: Icon(
                      Icons.water_drop,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          bool isSpecial = isSpecialDay(day);
          bool isPink = isPinkDay(day);

          return Container(
            padding: const EdgeInsets.only(left: 5, top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 1.5,
              ),
              color: Colors.pink.withOpacity(0.5),
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${day.day}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (isSpecial)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 10,
                    ),
                    child: Image.asset(
                      'assets/images/leaf.png',
                      width: 16,
                      height: 16,
                    ),
                  ),
                if (isPink)
                  const Padding(
                    padding: EdgeInsets.only(top: 3, left: 10),
                    child: Icon(
                      Icons.water_drop,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      daysOfWeekHeight: 50,
      rowHeight: 60,
    );
  }
}
