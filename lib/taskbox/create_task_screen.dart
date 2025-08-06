import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreen();
}

class _CreateTaskScreen extends State<CreateTaskScreen> {
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController estimateCtl = TextEditingController();
  final TextEditingController descCtl = TextEditingController();

  final TextEditingController taskDateCtl = TextEditingController();
  final TextEditingController dueDateCtl = TextEditingController();

  String? selectedProject;
  String? selectedStatus;
  String? selectedPriority;
  String? selectedAssignee;
  String? selectedWatchers;

  List<String> sampleOptions = ["Option 1", "Option 2", "Option 3"];

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('MM/dd/yy').format(picked);
    }
  }

  Widget buildDropdownField(
    String label,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          border: InputBorder.none,
        ),
        hint: Text(label),
        items: sampleOptions.map((option) {
          return DropdownMenuItem<String>(value: option, child: Text(option));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    int? maxLength,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              if (maxLength != null)
                Text(
                  "${controller.text.length}/$maxLength",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          TextField(
            maxLines: label == "Description" ? 4 : 1,
            controller: controller,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
              counterText: "",
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget buildDateField(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _pickDate(controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F7FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                enabled: false,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                  hintText: "mm/dd/yy",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const Icon(Icons.calendar_month, size: 18, color: Colors.black),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Taskbox',
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownField(
                    "Select Project*",
                    selectedProject,
                    (val) => setState(() => selectedProject = val),
                  ),
                  const SizedBox(height: 12),

                  buildTextField(
                    "Title*",
                    titleCtl,
                    hint: "Enter Title",
                    maxLength: 50,
                  ),
                  const SizedBox(height: 12),

                  buildDropdownField(
                    "Status*",
                    selectedStatus,
                    (val) => setState(() => selectedStatus = val),
                  ),
                  const SizedBox(height: 12),

                  buildDropdownField(
                    "Priority*",
                    selectedPriority,
                    (val) => setState(() => selectedPriority = val),
                  ),
                  const SizedBox(height: 12),

                  buildDropdownField(
                    "Assignee*",
                    selectedAssignee,
                    (val) => setState(() => selectedAssignee = val),
                  ),
                  const SizedBox(height: 12),

                  buildDropdownField(
                    "Watchers*",
                    selectedWatchers,
                    (val) => setState(() => selectedWatchers = val),
                  ),
                  const SizedBox(height: 12),

                  buildDateField("Task Date*", taskDateCtl),
                  const SizedBox(height: 12),

                  buildDateField("Due Date*", dueDateCtl),
                  const SizedBox(height: 12),

                  buildTextField(
                    "Original Estimate",
                    estimateCtl,
                    hint: "hh:mm (e.g. 02:05)",
                  ),
                  const SizedBox(height: 12),

                  buildTextField(
                    "Description",
                    descCtl,
                    hint: "Enter description",
                  ),
                  const SizedBox(height: 12),

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
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
