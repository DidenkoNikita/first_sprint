import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarOfEventsHome extends StatelessWidget {
  const CalendarOfEventsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> daysArray = [];
    final int currentDay = DateTime.now().day;
    final int currentMonth = DateTime.now().month;
    int daysInMonthFunc(int year, int month) {
      return DateTime(year, month + 1, 0).day;
    }

    final int daysInMonth =
        daysInMonthFunc(DateTime.now().year, DateTime.now().month);

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime currentDate =
          DateTime(DateTime.now().year, currentMonth, day);
      final String dayOfMonth = DateFormat.d().format(currentDate);
      final String dayOfWeek = DateFormat.E().format(currentDate);

      daysArray.add({'dayOfMonth': dayOfMonth, 'dayOfWeek': dayOfWeek});
    }

    final int initialScrollIndex = currentDay - 1;

    return Container(
      width: 365,
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(223, 187, 255, 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calendar of events',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              InkWell(
                child: const Text(
                  'All dates',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            scrollDirection: Axis.horizontal,
            controller: ScrollController(
              initialScrollOffset: 60.0 * (initialScrollIndex - 0.7),
            ),
            child: Row(
              children: daysArray.map((day) {
                return Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: int.parse(day['dayOfMonth'].toString()) == currentDay
                        ? const Color.fromRGBO(227, 245, 99, 1)
                        : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(117, 79, 246, 0.35),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day['dayOfMonth'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        day['dayOfWeek'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
