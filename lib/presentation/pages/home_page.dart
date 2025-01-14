import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String getFormattedDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  String getMonth(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  bool isSpecialDay(DateTime day) {
    return (day.day >= 1 && day.day <= 3) || (day.day >= 25 && day.day <= 31);
  }

  bool isPinkDay(DateTime day) {
    return day.day >= 16 && day.day <= 19;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = getFormattedDate(_focusedDay);
    String month = getMonth(_focusedDay);

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //! Top part of calendar page:
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.water_drop_sharp,
                              size: 25,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          Text(
                            month,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    //! Calendar:
                    TableCalendar(
                      firstDay: DateTime(2020, 1, 1),
                      lastDay: DateTime(2026, 1, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                      _selectedDay != null && isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
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
                    ),
                    const SizedBox(height: 20),
                    //! Bottom_texts:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Cycle Day 12 - Follicular Phase",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          //! Edit_button:
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.water_drop,
                                  size: 15,
                                  color: Colors.pinkAccent,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //! Line:
                    Container(height: 1, color: Colors.grey[200]),
                    const SizedBox(height: 20),
                    //! bottom_part:
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 24),
                          width: 72,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.orange[500],
                          ),
                          child: const Text(
                            "Medium",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 8,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Chance of getting pregnant",
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}