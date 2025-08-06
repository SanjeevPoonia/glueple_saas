import 'package:flutter/material.dart';
import 'package:glueplenew/taskbox/taskbox_home.dart';

class SelectYearDialog extends StatefulWidget {
  const SelectYearDialog({super.key});

  @override
  State<SelectYearDialog> createState() => _SelectYearDialog();
}

class _SelectYearDialog extends State<SelectYearDialog> {
  int selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    final years = [2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030];

    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.34,
        minChildSize: 0.34,
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
                    Text(
                      "More",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedYear--;
                          });
                        },
                      ),
                      ...years.map((year) {
                        final isSelected = year == selectedYear;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedYear = year;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF00C797)
                                    : const Color(0xFF99E8DC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$year',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedYear++;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskBoxHome()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
