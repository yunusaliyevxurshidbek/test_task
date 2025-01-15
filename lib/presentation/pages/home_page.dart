import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/presentation/widgets/calendar_widget.dart';
import '../../core/utils/date_utils.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadCalendarData()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is CalendarDataLoaded) {
                String formattedDate = getFormattedDate(state.focusedDay);
                String month = getMonth(state.focusedDay);

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //! Top part of calendar page:
                        TopBar(month: state.month),

                        const SizedBox(height: 15),

                        //! Calendar_widget:
                        CalendarWidget(
                          focusedDay: state.focusedDay,
                          selectedDay: state.selectedDay,
                          specialDays: const [],
                          pinkDays: const [],
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
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
