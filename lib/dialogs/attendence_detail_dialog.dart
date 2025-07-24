import 'package:flutter/material.dart';

class AttendanceDetailDialog extends StatefulWidget {
  @override
  State<AttendanceDetailDialog> createState() => _AttendanceDetailDialog();
}

class _AttendanceDetailDialog extends State<AttendanceDetailDialog> {
  int selectedType = 0;
  String selectedIOType = "";
  TextEditingController subjectCtl = TextEditingController(text: "");
  TextEditingController reasonCtl = TextEditingController();
  String startDate = "22-04-2023";
  String endDate = "23-04-2023";
  int startDayType = 0; // 0: First Half, 1: Second Half, 2: Full Day
  int endDayType = 2;
  String? attachedFileName;

  final List<String> dayTypes = ["First Half", "Second Half", "Full Day"];

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.58,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Spacer(),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Attendance detail",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.search),
                    const SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 6),
                ...records.map((record) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6F7FF),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              record['time']?.toString() ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(4),
                          value: record['time'] == "-" ? 0.1 : 1,
                          minHeight: 6,
                          backgroundColor: Colors.blue.shade100,
                          color: Color(0xFF1B81A4),
                        ),
                        SizedBox(height: 12),
                        Divider(),
                        SizedBox(height: 12),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusColumn(String label, String status, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(
          status,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
