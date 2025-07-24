import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saas_glueple/attendance/attendance_17.dart';
import 'package:saas_glueple/attendance/attendance_correction.dart';
import 'package:saas_glueple/attendance/attendancedetail.dart';
import 'package:saas_glueple/dialogs/attendence_detail_dialog.dart';
import 'package:saas_glueple/dialogs/leave_management_dialog.dart';
import 'package:saas_glueple/leave_management/leave_management_screen.dart';
import 'package:saas_glueple/widget/appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendance14 extends StatefulWidget {
  const Attendance14({super.key});

  @override
  State<Attendance14> createState() => _Attendance14State();
}

class _Attendance14State extends State<Attendance14> {
  int selectedCenter = 0;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        "date": "18 Sept 2023",
        "time": "09:05:00",
        "firstHalf": "PR",
        "secondHalf": "PR",
        "break": "00:59:00",
        "color1": Colors.green,
        "color2": Colors.green,
      },
    ];

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Attendance',
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaveManagementScreen(),
                  ),
                );
              },
            ),
            const IconButton(
              icon: Icon(Icons.category, size: 30, color: Colors.white),
              onPressed: null,
            ),
          ],
        ),
        body: Stack(children: [
          // Fixed glowing background
          IgnorePointer(
            child: Stack(
              children: [
                Positioned(
                  top: 75,
                  left: -5,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C797).withOpacity(0.8),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 75,
                  right: -10,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1B81A4).withOpacity(0.8),
                          blurRadius: 80,
                          spreadRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(4),
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(
                                        () => selectedCenter = 0,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedCenter == 0
                                              ? const Color(0xFF1B81A4)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          // boxShadow: selectedCenter == 0
                                          //     ? [
                                          //         BoxShadow(
                                          //           color: Colors.grey.withOpacity(0.3),
                                          //           spreadRadius: 2,
                                          //           blurRadius: 5,
                                          //           offset: const Offset(0, 3),
                                          //         )
                                          //   ]
                                          // : [],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Dashboard",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: selectedCenter == 0
                                                  ? Colors.white
                                                  : const Color(
                                                      0xFF1B81A4,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(
                                        () => selectedCenter = 1,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedCenter == 1
                                              ? const Color(0xFF1B81A4)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          // boxShadow: selectedCenter == 1
                                          //     ? [
                                          //         BoxShadow(
                                          //           color: Colors.grey.withOpacity(0.3),
                                          //           spreadRadius: 2,
                                          //           blurRadius: 5,
                                          //           offset: const Offset(0, 3),
                                          //         )
                                          //   ]
                                          // : [],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Calendar",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: selectedCenter == 1
                                                  ? Colors.white
                                                  : const Color(
                                                      0xFF1B81A4,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectedCenter == 0)
                        Positioned(
                          top: 100,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // SizedBox(height: 2),
                                        Text(
                                          '19 Sept 2023',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...records.map((record) {
                                    return Padding(
                                      padding: const EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade400,
                                          ),
                                          color: Colors.white60,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            12.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _statusColumn(
                                                "First Half",
                                                record['firstHalf']
                                                        ?.toString() ??
                                                    '',
                                                record['color1'] as Color,
                                              ),
                                              _statusColumn(
                                                "Second Half",
                                                record['secondHalf']
                                                        ?.toString() ??
                                                    '',
                                                record['color2'] as Color,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Total Break",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    record['break']
                                                            ?.toString() ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 16),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    padding: const EdgeInsets.all(
                                      16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: _buildTrackedTimeSection(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      18.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                              color: const Color(
                                                0xFF00C797,
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      LeaveManagementDialog(),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 16,
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "Leave Management",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                              color: const Color(
                                                0xFF1B81A4,
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AttendanceCorrection(),
                                                  )),
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 16,
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "Apply Correction",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (selectedCenter == 1)
                        Positioned(
                          top: 100,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: TableCalendar(
                                  firstDay: DateTime.utc(
                                    2020,
                                    1,
                                    1,
                                  ),
                                  lastDay: DateTime.utc(
                                    2030,
                                    12,
                                    31,
                                  ),
                                  focusedDay: _focusedDay,
                                  calendarFormat: CalendarFormat.month,
                                  calendarStyle: const CalendarStyle(
                                    todayDecoration: BoxDecoration(
                                      color: Color(0xFF304C9F),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                      color: Color(0xFF00C797),
                                      shape: BoxShape.circle,
                                    ),
                                    markerDecoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    weekendTextStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  headerStyle: const HeaderStyle(
                                    titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    leftChevronIcon: Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                    rightChevronIcon: Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                  ),
                                  eventLoader: (day) => _getEventsForDay(day),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(
                                      day,
                                      _selectedDay,
                                    );
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                  calendarBuilders: CalendarBuilders(
                                    selectedBuilder:
                                        (context, day, focusedDay) {
                                      final events = _getEventsForDay(day);
                                      if (events.isNotEmpty) {
                                        String event = events.first;
                                        Color color;
                                        String abbr;
                                        if (event == "Present") {
                                          color = Colors.green;
                                          abbr = "PR";
                                        } else if (event == "Absent") {
                                          color = Colors.red;
                                          abbr = "AB";
                                        } else if (event == "Week Off") {
                                          color = Colors.indigo;
                                          abbr = "WO";
                                        } else if (event == "Public Holiday") {
                                          color = const Color(
                                            0xFF2B7B8A,
                                          );
                                          abbr = "PH";
                                        } else if (event == "Paid Leave") {
                                          color = Colors.indigo;
                                          abbr = "PL";
                                        } else if (event == "Leave w/o Pay") {
                                          color = Colors.orange;
                                          abbr = "LW";
                                        } else if (event == "Half Day Absent") {
                                          color = const Color(
                                            0xFFFF0000,
                                          );
                                          abbr = "HD";
                                        } else {
                                          color = const Color(
                                            0xFF1B81A4,
                                          );
                                          abbr = event
                                              .substring(0, 2)
                                              .toUpperCase();
                                        }
                                        return CircleAvatar(
                                          backgroundColor: color,
                                          radius: 18,
                                          child: Text(
                                            abbr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFF1B81A4),
                                          radius: 18,
                                          child: Text(
                                            '${day.day}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    todayBuilder: (context, day, focusedDay) {
                                      if (!isSameDay(
                                        day,
                                        _selectedDay,
                                      )) {
                                        return CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFF304C9F),
                                          radius: 18,
                                          child: Text(
                                            '${day.day}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return null;
                                      }
                                    },
                                    defaultBuilder: (context, day, focusedDay) {
                                      final events = _getEventsForDay(day);
                                      if (events.isNotEmpty) {
                                        String event = events.first;
                                        Color color;
                                        if (event == "Present")
                                          color = Colors.green;
                                        else if (event == "Absent")
                                          color = Colors.red;
                                        else if (event == "Week Off")
                                          color = Colors.indigo;
                                        else if (event == "Public Holiday")
                                          color = const Color(
                                            0xFF2B7B8A,
                                          );
                                        else if (event == "Paid Leave")
                                          color = Colors.indigo;
                                        else if (event == "Leave w/o Pay")
                                          color = Colors.orange;
                                        else if (event == "Half Day Absent")
                                          color = const Color(
                                            0xFFFF0000,
                                          );
                                        else
                                          color = const Color(
                                            0xFF1B81A4,
                                          );
                                        return Center(
                                          child: Text(
                                            '${day.day}',
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                    dowBuilder: (context, day) {
                                      final text = [
                                        'S',
                                        'M',
                                        'T',
                                        'W',
                                        'T',
                                        'F',
                                        'S',
                                      ][day.weekday % 7];
                                      return Center(
                                        child: Text(
                                          text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _legend(
                                          "Today",
                                          const Color(0xFF304C9F),
                                          "T",
                                        ),
                                        _legend(
                                          "Present",
                                          const Color(0xFF1D963A),
                                          "PR",
                                        ),
                                        _legend(
                                          "Public Holiday",
                                          const Color(0xFF2B7B8A),
                                          "PH",
                                        ),
                                        _legend(
                                          "Week Off",
                                          const Color(0xFF5C5959),
                                          "WO",
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _legend(
                                          "Paid Leave",
                                          Colors.indigo,
                                          "PL",
                                        ),
                                        _legend(
                                          "Leave w/o Pay",
                                          Colors.orange,
                                          "LW",
                                        ),
                                        _legend(
                                          "Half Day Absent",
                                          const Color(0xFFFF0000),
                                          "HD",
                                        ),
                                        _legend(
                                          "Absent",
                                          Colors.red,
                                          "AB",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsetsGeometry.all(0),
                                child: Wrap(
                                  spacing: 7,
                                  children: [
                                    _filterButton("Today"),
                                    _filterButton("Yesterday"),
                                    _filterButton("This Month"),
                                    _filterButton("Last Month"),
                                    _filterButton("Last 3 Month"),
                                    _filterButton("Last 6 Month"),
                                    _filterButton("Last Year"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF00C797),
                                        Color(0xFF1B81A4),
                                      ],
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 12,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "View Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                    ],
                  )))
        ]));
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B81A4),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackedTimeSection() {
    double tracked = 3.2;
    double total = 9.0;
    double progress = (total > 0) ? (tracked / total).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFE6FAF6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset('assets/timer.png', width: 28, height: 28),
            ),
            const SizedBox(width: 8),
            const Text(
              "Tracked Time",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            const Text(
              "03:20:00",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(4),
          value: progress,
          backgroundColor: Colors.grey[300],
          color: const Color(0xFF1B81A4),
          minHeight: 6,
        ),
        const SizedBox(height: 16),
        _divider(),
        _buildKeyValueRow("Full Time", "09:00:00"),
        _divider(),
        _buildKeyValueRow("Left", "05:40:00"),
        _divider(),
        _buildKeyValueRow("First In", "09:36:00"),
        _divider(),
        _buildKeyValueRow("Last Out", "15:20:00"),
        _divider(),
        _buildKeyValueRow("Total Break", "00:42:00"),
        _divider(),
        _buildKeyValueRow("Login Device", "Mobile", isLink: true),
        _divider(),
        _buildKeyValueRow("Device IP Address", "122486896326", isLink: true),
        _divider(),
        const SizedBox(height: 8),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Attendance17(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "View Activity",
                style: TextStyle(
                  color: Color(0xFF1B81A4),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPastRecordSection() {
    final records = [
      {
        "date": "18 Sept 2023",
        "time": "09:05:00",
        "firstHalf": "PR",
        "secondHalf": "PR",
        "break": "00:59",
        "color1": Colors.green,
        "color2": Colors.green,
      },
      {
        "date": "17 Sept 2023",
        "time": "09:02:00",
        "firstHalf": "PR",
        "secondHalf": "AB",
        "break": "01:15",
        "color1": Colors.green,
        "color2": Colors.red,
      },
      {
        "date": "16 Sept 2023",
        "time": "-",
        "firstHalf": "WO",
        "secondHalf": "WO",
        "break": "-",
        "color1": Colors.indigo,
        "color2": Colors.indigo,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FAF6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/timer.png', width: 28, height: 28),
              ),
              const SizedBox(width: 10),
              const Text(
                'Past Record',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _divider(),
          const SizedBox(height: 6),
          ...records.map((record) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        record['date']?.toString() ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        record['time']?.toString() ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(4),
                    value: record['time'] == "-" ? 0.1 : 1,
                    minHeight: 6,
                    backgroundColor: Colors.blue.shade100,
                    color: const Color(0xFF1B81A4),
                  ),
                  const SizedBox(height: 12),
                  _divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statusColumn(
                        "First Half",
                        record['firstHalf']?.toString() ?? '',
                        record['color1'] as Color,
                      ),
                      _statusColumn(
                        "Second Half",
                        record['secondHalf']?.toString() ?? '',
                        record['color2'] as Color,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Break",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            record['break']?.toString() ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          _divider(),
          const SizedBox(height: 8),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "See More",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1B81A4),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusColumn(String label, String status, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        Text(
          status,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildKeyValueRow(String key, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          GestureDetector(
            onTap: isLink ? () {} : null,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isLink ? const Color(0xFF1B81A4) : Colors.black,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordContainer(
    String key,
    String value, {
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          GestureDetector(
            onTap: isLink ? () {} : null,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isLink ? const Color(0xFF1B81A4) : Colors.black,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFE0E0E0));

  Widget _buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    if (day.day == 3 || day.day == 4 || day.day == 5) {
      return ["Present"];
    } else if (day.day == 10) {
      return ["Public Holiday"];
    } else if (day.day == 14) {
      return ["Half Day Absent"];
    } else if (day.day == 17) {
      return ["Absent"];
    }
    return [];
  }

  Widget _legend(String label, Color color, String abbreviation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Text(
              abbreviation,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String label) {
    return TextButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.blue.shade50,
        side: BorderSide(color: Colors.blue.shade800, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blue.shade800,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
