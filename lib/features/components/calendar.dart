import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final bool openCalendar;
  final Function(String) setStateDate;
  final Function(bool) setOpenCalendar;

  const DatePicker({
    Key? key,
    required this.openCalendar,
    required this.setStateDate,
    required this.setOpenCalendar,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime viewDate;
  late String viewMonthName;
  late String viewYear;
  late bool showYearList;
  late DateTime selectedDate;
  late bool showMonthList;
  late List<CalendarEntry> calendarEntries;

  final List<String> daysOfTheWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  late int year;
  late List<int> yearList;

  @override
  void initState() {
    super.initState();
    year = DateTime.now().year - 60;
    final currentYear = DateTime.now().year;
    yearList = List.generate(61, (index) => currentYear - 60 + index);
    viewDate = DateTime.now();
    viewYear = viewDate.year.toString();
    viewMonthName = DateFormat.MMMM().format(viewDate);
    showYearList = false;
    selectedDate = DateTime.now();
    showMonthList = false;
    calendarEntries = [];

    computeData();
  }

  void computeData() {
    final months = DateFormat.MMMM().dateSymbols.MONTHS;
    final month = viewDate.month;
    final monthName = months[month - 1];
    final year = viewDate.year;
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final entries = <CalendarEntry>[];
    final firstOfMonth = DateTime(year, month, 1);
    final numberOfFillerDays = (firstOfMonth.weekday - 1 + 7) % 7;
    for (var fillerDay = numberOfFillerDays; fillerDay > 0; fillerDay--) {
      final prevMonthDate = firstOfMonth.subtract(Duration(days: fillerDay));
      entries.add(CalendarEntry(
        day: prevMonthDate.day,
        date: prevMonthDate,
      ));
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      entries.add(CalendarEntry(
        day: day,
        date: date,
      ));
    }
    final lastOfMonth = DateTime(year, month, daysInMonth);
    final numberOfTrailingDays = (7 - lastOfMonth.weekday) % 7;
    for (var trailingDay = 1;
        trailingDay <= numberOfTrailingDays;
        trailingDay++) {
      final nextMonthDate = lastOfMonth.add(Duration(days: trailingDay));
      entries.add(CalendarEntry(
        day: nextMonthDate.day,
        date: nextMonthDate,
      ));
    }

    setState(() {
      viewMonthName = monthName;
      viewYear = year.toString();
      calendarEntries = entries;
    });
  }

  bool isDateToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  void previousMonth() {
    setState(() {
      viewDate = DateTime(viewDate.year, viewDate.month - 1);
    });
    computeData();
  }

  void nextMonth() {
    setState(() {
      viewDate = DateTime(viewDate.year, viewDate.month + 1);
    });
    computeData();
  }

  void previousYear() {
    setState(() {
      viewDate = DateTime(viewDate.year - 1, viewDate.month);
    });
    computeData();
  }

  void nextYear() {
    setState(() {
      viewDate = DateTime(viewDate.year + 1, viewDate.month);
    });
    computeData();
  }

  void selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void handleMonthClick() {
    setState(() {
      showMonthList = !showMonthList;
      showYearList = false;
    });
  }

  void handleYearClick() {
    setState(() {
      showYearList = !showYearList;
      showMonthList = false;
    });
  }

  void handleMonthSelect(int month) {
    setState(() {
      viewDate = DateTime(viewDate.year, month + 1);
      showMonthList = false;
    });
    computeData();
  }

  void handleYearSelect(int year) {
    setState(() {
      viewDate = DateTime(year, viewDate.month);
      showYearList = false;
    });
    computeData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
      shadowColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        width: 370,
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(36, 36, 36, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed:
                        showMonthList || showYearList ? null : previousMonth,
                    icon: SvgPicture.asset('assets/svg/chevron-left.svg')),
                GestureDetector(
                  onTap: () {
                    if (!showYearList && !showMonthList) {
                      handleMonthClick();
                    }
                  },
                  child: Text(
                    viewMonthName.substring(0, 3),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: showMonthList || showYearList ? null : nextMonth,
                  icon: SvgPicture.asset('assets/svg/chevron-right.svg'),
                ),
                IconButton(
                  onPressed:
                      showMonthList || showYearList ? null : previousYear,
                  icon: SvgPicture.asset('assets/svg/chevron-left.svg'),
                ),
                GestureDetector(
                  onTap: () {
                    if (!showYearList && !showMonthList) {
                      handleYearClick();
                    }
                  },
                  child: Text(
                    viewYear,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: showMonthList || showYearList ? null : nextYear,
                  icon: SvgPicture.asset('assets/svg/chevron-right.svg'),
                ),
              ],
            ),
            SizedBox(
              width: 325,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: daysOfTheWeek.map((day) {
                  return Text(
                    day,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 325,
              child: Center(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: calendarEntries.map((entry) {
                    final isToday = isDateToday(entry.date);
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(36, 36, 36, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isToday
                              ? const Color.fromRGBO(223, 197, 255, 1)
                              : const Color.fromRGBO(36, 36, 36, 1),
                          width: 1,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => selectDate(entry.date),
                        child: Text(
                          entry.day.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => widget.setOpenCalendar(!widget.openCalendar),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: 64,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(227, 245, 99, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final date = selectedDate;
                      final day = date.day;
                      final month = date.month.toString().padLeft(2, '0');
                      final year = date.year;
                      final formattedDate = '$day/$month/$year';
                      widget.setStateDate(formattedDate);
                      widget.setOpenCalendar(!widget.openCalendar);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
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
}

class CalendarEntry {
  final int day;
  final DateTime date;

  CalendarEntry({
    required this.day,
    required this.date,
  });
}
