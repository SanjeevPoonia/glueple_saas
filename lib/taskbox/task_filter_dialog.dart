import 'package:flutter/material.dart';

class TaskFilterBottomSheet extends StatefulWidget {
  const TaskFilterBottomSheet({super.key});

  @override
  State<TaskFilterBottomSheet> createState() => _TaskFilterBottomSheet();
}

class _TaskFilterBottomSheet extends State<TaskFilterBottomSheet> {
  List<Map<String, String>> employees = [
    {"name": "Employee1", "id": "QD1234"},
    {"name": "Employee2", "id": "QD4567"},
    {"name": "Employee3", "id": "QD1234"},
    {"name": "Employee4", "id": "QD4567"},
    {"name": "Employee5", "id": "QD1234"},
    {"name": "Employee6", "id": "QD4567"},
    {"name": "Employee7", "id": "QD1234"},
    {"name": "Employee8", "id": "QD4567"},
  ];

  List<bool> isChecked = List.filled(8, false);
  bool selectAll = false;

  int selectedFilterIndex = 0;
  final List<String> filters = ["Employee ID", "Status", "Project"];

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      isChecked = List.filled(employees.length, selectAll);
    });
  }

  void toggleSingleSelect(int index, bool? value) {
    setState(() {
      isChecked[index] = value ?? false;
      selectAll = isChecked.every((e) => e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
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
                    Text(
                      "Filter",
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
                SizedBox(height: 8),

                //Mid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Filters
                    Container(
                      width: 120,
                      // color: const Color(0xFFF5F5F5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(filters.length, (index) {
                          final isSelected = selectedFilterIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedFilterIndex = index;
                                });
                              },

                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: isSelected
                                    ? const Color(0xFF007398)
                                    : Colors.grey[300],
                                foregroundColor: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fixedSize: const Size(120, 45),
                                elevation: 0,
                              ),
                              child: Text(
                                filters[index],
                                style: const TextStyle(fontSize: 12.5),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Right Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search Bar
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1EEF9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search here",
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.search),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Select Employee",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),

                            SizedBox(
                              height: 350,
                              child: ListView(
                                children: [
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,

                                    title: const Text(
                                      "Select all",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    value: selectAll,
                                    onChanged: toggleSelectAll,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                  ...List.generate(employees.length, (index) {
                                    final employee = employees[index];
                                    return CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      checkColor: Colors.white,
                                      title: Text(
                                        "${employee["name"]} (${employee["id"]})",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      value: isChecked[index],
                                      onChanged: (value) =>
                                          toggleSingleSelect(index, value),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Apply Button
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
                    onPressed: () {},
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
