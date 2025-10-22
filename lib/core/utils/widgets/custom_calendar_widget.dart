// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:hr_app/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({
    super.key,
    this.width,
    this.height,
    this.calendarList,
    this.onSelectedDate,
  });

  final double? width;
  final double? height;
  final List<dynamic>? calendarList;
  final Future Function(List<dynamic>? selectedDateTime)? onSelectedDate;

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  late DateTime _currentMonth;
  late Map<DateTime, List<Map<String, String>>> _events;
  late Map<DateTime, Color> _eventColors;
  DateTime? _selectedDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeCalendar());
  }

  Future<void> _initializeCalendar() async {
    setState(() => _isLoading = true);

    final events = widget.calendarList ?? [];
    await Future.delayed(const Duration(milliseconds: 30)); // Frame sync

    _events = _groupEvents(events);
    _eventColors = _assignColors(events);

    _triggerDateSelection(_selectedDate!);
    setState(() => _isLoading = false);
  }

  void _triggerDateSelection(DateTime date) {
    final selectedDateString = DateFormat('yyyy-MM-dd').format(date);
    final selectedEvents = widget.calendarList
            ?.where((event) =>
                (event['timeEntry_Date']
                    ?.toString()
                    .startsWith(selectedDateString)) ??
                false)
            .toList() ??
        [];

    AppState().selectedDate = selectedDateString;
    AppState().selectedEventsJSon = selectedEvents;

    widget.onSelectedDate?.call(selectedEvents);
  }

  Map<DateTime, List<Map<String, String>>> _groupEvents(List<dynamic> events) {
    final groupedEvents = <DateTime, List<Map<String, String>>>{};
    for (var event in events) {
      final dateStr = event['timeEntry_Date'];
      if (dateStr == null) continue;

      final parsedDate = DateTime.parse(dateStr.split('T')[0]);
      final remark = event['remark'] ?? 'No Remark';

      groupedEvents.putIfAbsent(parsedDate, () => []);
      groupedEvents[parsedDate]!.add({'name': remark, 'time': 'All Day'});
    }
    return groupedEvents;
  }

  Map<DateTime, Color> _assignColors(List<dynamic> events) {
    final colorMap = <DateTime, Color>{};
    for (var event in events) {
      final dateStr = event['timeEntry_Date'];
      if (dateStr == null) continue;

      final parsedDate = DateTime.parse(dateStr.split('T')[0]);
      final rawRemark = (event['remark'] ?? '').toString().toLowerCase().trim();

      Color color;
      if (rawRemark.contains('business leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('sick leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('annual leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('maternity leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('military leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('ordination leave')) {
        color = Colors.blue;
      } else if (rawRemark.contains('sick leave (without pay)​')) {
        color = Colors.blue;
      } else if (rawRemark.contains('maternity leave(without pay)​')) {
        color = Colors.blue;
      } else if (rawRemark.contains('business leave (without pay)​​')) {
        color = Colors.blue;
      } else if (rawRemark.contains('absence')) {
        color = Colors.red;
      } else if (rawRemark.contains('late')) {
        color = Colors.red;
      } else if (rawRemark.contains('normal')) {
        color = Colors.green;
      } else {
        color = Colors.transparent;
      }

      colorMap[parsedDate] = color;
    }
    return colorMap;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final leadingEmptyDays = firstDay.weekday % 7;
    final today = DateTime.now();

    return Container(
      width: widget.width,
      height: widget.height,
      color: const Color(0xFFFFF2E3),
      child: Column(
        children: [
          _buildMonthHeader(),
          _buildWeekdayHeader(),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
              ),
              itemCount: daysInMonth + leadingEmptyDays,
              itemBuilder: (context, index) {
                if (index < leadingEmptyDays) return const SizedBox.shrink();
                final day = index - leadingEmptyDays + 1;
                final date =
                    DateTime(_currentMonth.year, _currentMonth.month, day);
                final events = _events[date] ?? [];
                final color = _eventColors[date] ?? Colors.transparent;

                return CalendarDay(
                  day: day,
                  events: events,
                  eventColor: color,
                  isSelected: _isSameDay(_selectedDate ?? today, date),
                  isToday: _isSameDay(date, today),
                  onTap: () {
                    if (!_isSameDay(_selectedDate ?? today, date)) {
                      setState(() => _selectedDate = date);
                      _triggerDateSelection(date);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.orange,
        child: Center(
          child: Text(
            DateFormat('MMMM yyyy').format(_currentMonth),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _buildWeekdayHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
            .map((day) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            .toList(),
      );
}

class CalendarDay extends StatelessWidget {
  final int day;
  final List<Map<String, String>> events;
  final Color? eventColor;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  const CalendarDay({
    super.key,
    required this.day,
    required this.events,
    this.eventColor,
    this.isToday = false,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected
              ? Colors.orange
              : isToday
                  ? Colors.blue
                  : const Color(0xFFFFF2E3),
          border: isSelected
              ? Border.all(color: Colors.deepOrange, width: 2)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (events.isNotEmpty)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: eventColor ?? Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
