import 'package:flutter/material.dart';
import 'package:glueplenew/widgets/appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreen();
}

class _LeaveManagementScreen extends State<LeaveManagementScreen> {
  int selectedCenter = 0;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final DateTime _today = DateTime.now();

  List TeamImages = [
    'assets/natasha.png',
    'assets/sagar.png',
    'assets/girlavatar.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Leave Management',
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const IconButton(
            icon: Icon(Icons.category, size: 30, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      body: Stack(
        children: [
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
                  // Toggle (Dashboard / Calendar)
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedCenter = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCenter == 0
                                      ? Color(0xFF1B81A4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    "Dashboard",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedCenter == 0
                                          ? Colors.white
                                          : Color(0xFF1B81A4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedCenter = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCenter == 1
                                      ? Color(0xFF1B81A4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    "Calendar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedCenter == 1
                                          ? Colors.white
                                          : Color(0xFF1B81A4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  if (selectedCenter == 0)
                    // Sample content block — add your widgets below
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Leave\nBalance",
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      height: 1, // Reduce line spacing
                                    ),
                                  ),
                                  // Add animation(assets/Automation.json)
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: Lottie.asset(
                                        'assets/Automation.json',
                                        repeat: true,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatCard("05", "Paid\nLeaves"),
                                  _buildStatCard(
                                    "1.5",
                                    "Comp\nOff Balance",
                                    Image.asset(
                                      'assets/arrow_right.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  _buildStatCard("00", "Sick\nLeave"),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatCard("00", "Sick\nLeave"),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // More content...
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Leave Request",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 10),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: double.maxFinite,
                                ),
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    fixedSize: Size(double.maxFinite, 50),
                                    side: const BorderSide(
                                      color: Color(
                                        0xFF00C797,
                                      ), // Changed border color
                                      width: 1,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color(0xFF00C797),
                                      ),
                                      Spacer(),
                                      const Text(
                                        'Apply',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00C797),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Team Leaves",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                // height: 80,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(155, 0, 199, 152),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 18),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (
                                          int i = 0;
                                          i < TeamImages.length;
                                          i++
                                        )
                                          Align(
                                            widthFactor: 0.5,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                TeamImages[i],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(width: 18),

                                    Text(
                                      "and 5 more....",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                          ),
                                        ],
                                        gradient: LinearGradient(
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
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "View",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // My Leaves and My Corrections
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              _buildMyLeavesCard(),
                              SizedBox(height: 20),
                              _buildMyCorrectionsCard(),
                            ],
                          ),
                        ),
                      ],
                    ),

                  if (selectedCenter == 1)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: _focusedDay,
                            calendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
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
                              weekendTextStyle: TextStyle(color: Colors.red),
                            ),
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              formatButtonVisible: false,
                              titleCentered: true,
                              leftChevronIcon: Icon(Icons.arrow_back_ios),
                              rightChevronIcon: Icon(Icons.arrow_forward_ios),
                            ),
                            eventLoader: (day) => _getEventsForDay(day),
                            selectedDayPredicate: (day) {
                              return isSameDay(day, _selectedDay);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                            calendarBuilders: CalendarBuilders(
                              selectedBuilder: (context, day, focusedDay) {
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
                                    color = Color(0xFF2B7B8A);
                                    abbr = "PH";
                                  } else if (event == "Paid Leave") {
                                    color = Colors.indigo;
                                    abbr = "PL";
                                  } else if (event == "Leave w/o Pay") {
                                    color = Colors.orange;
                                    abbr = "LW";
                                  } else if (event == "Half Day Absent") {
                                    color = Color(0xFFFF0000);
                                    abbr = "HD";
                                  } else {
                                    color = Color(0xFF1B81A4);
                                    abbr = event.substring(0, 2).toUpperCase();
                                  }
                                  return CircleAvatar(
                                    backgroundColor: color,
                                    radius: 18,
                                    child: Text(
                                      abbr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                } else {
                                  return CircleAvatar(
                                    backgroundColor: Color(0xFF1B81A4),
                                    radius: 18,
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                              },
                              todayBuilder: (context, day, focusedDay) {
                                if (!isSameDay(day, _selectedDay)) {
                                  return CircleAvatar(
                                    backgroundColor: Color(0xFF304C9F),
                                    radius: 18,
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
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
                                    color = Color(0xFF2B7B8A);
                                  else if (event == "Paid Leave")
                                    color = Colors.indigo;
                                  else if (event == "Leave w/o Pay")
                                    color = Colors.orange;
                                  else if (event == "Half Day Absent")
                                    color = Color(0xFFFF0000);
                                  else
                                    color = Color(0xFF1B81A4);
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
                                    style: TextStyle(color: Colors.black),
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
                                    style: TextStyle(
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  _legend("Today", Color(0xFF304C9F), "T"),
                                  _legend("Present", Color(0xFF1D963A), "PR"),
                                  _legend(
                                    "Public Holiday",
                                    Color(0xFF2B7B8A),
                                    "PH",
                                  ),
                                  _legend("Week Off", Color(0xFF5C5959), "WO"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _legend("Paid Leave", Colors.indigo, "PL"),
                                  _legend("Leave w/o Pay", Colors.orange, "LW"),
                                  _legend(
                                    "Half Day Absent",
                                    Color(0xFFFF0000),
                                    "HD",
                                  ),
                                  _legend("Absent", Colors.red, "AB"),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsetsGeometry.all(0),
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
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
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
                                  borderRadius: BorderRadius.circular(12),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, [Image? image]) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B81A4),
                ),
              ),
              Spacer(),
              if (image != null) image,
            ],
          ),
          SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Add these helper widgets at the end of the class
  Widget _buildMyLeavesCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FAF6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/calendar.png',
                  width: 28,
                  height: 28,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'My Leaves',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8),
          _buildLeaveItem(
            'Unpaid Leave (UPL)',
            'Pending',
            Color(0xFFF5DD09),
            Color(0xFF1B81A4),
          ),
          SizedBox(height: 10),
          _buildLeaveItem(
            'Paid Leave (UPL)',
            'Pending',
            Color(0xFFF5DD09),
            Color(0xFF1B81A4),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey.shade300),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View All',

                style: TextStyle(
                  fontSize: 18,

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

  Widget _buildLeaveItem(
    String title,
    String status,
    Color statusColor,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF5FBFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('25-07-2023', style: TextStyle(fontWeight: FontWeight.w500)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final boxWidth = constraints.constrainWidth();
                      final dashWidth = 4.0;
                      final dashSpace = 4.0;
                      final dashCount = (boxWidth / (dashWidth + dashSpace))
                          .floor();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(dashCount, (_) {
                          return Container(
                            width: dashWidth,
                            height: 1,
                            color: Colors.black,
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
              Text('26-07-2023', style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              '1 day',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCorrectionsCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FAF6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/correction.png',
                  width: 28,
                  height: 28,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'My Corrections',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8),
          _buildCorrectionItem('18 Sept 2023', 'Pending', Color(0xFFF5DD09)),
          SizedBox(height: 10),
          _buildCorrectionItem('18 Sept 2023', 'Approved', Color(0xFF4CAF50)),
          SizedBox(height: 10),
          Divider(color: Colors.grey.shade300),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 18,
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

  Widget _buildCorrectionItem(String date, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF5FBFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: TextStyle(fontWeight: FontWeight.w800)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First Half',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'PR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D963A),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Second Half',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'AB',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Correction Time',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '00:59:00',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
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
              style: TextStyle(
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
