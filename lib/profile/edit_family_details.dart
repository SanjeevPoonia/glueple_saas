import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/dialogs/successful_dialog.dart';
import 'package:glueplenew/pending_scr/delete_entry_q.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';

class EditFamilyDetails extends StatefulWidget {
  const EditFamilyDetails({super.key});

  @override
  State<EditFamilyDetails> createState() => _EditFamilyDetails();
}

class _EditFamilyDetails extends State<EditFamilyDetails> {
  final TextEditingController fatherNameCtl = TextEditingController();
  final TextEditingController fatherDobCtl = TextEditingController();
  final TextEditingController motherNameCtl = TextEditingController();
  final TextEditingController motherDobCtl = TextEditingController();
  final TextEditingController spouseNameCtl = TextEditingController();
  final TextEditingController spouseDobCtl = TextEditingController();
  final TextEditingController firstChildNameCtl = TextEditingController();
  final TextEditingController firstChildDobCtl = TextEditingController();
  final TextEditingController secondChildNameCtl = TextEditingController();
  final TextEditingController secondChildDobCtl = TextEditingController();

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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
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
        title: 'Edit Profile Details',
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
                  const SizedBox(height: 6),
                  Text(
                    "Family Details",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Father's Name",
                    fatherNameCtl,
                    hint: "Enter Father's Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField("Father's Date of Birth", fatherDobCtl),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Mother's Name",
                    motherNameCtl,
                    hint: "Enter Mother's Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField("Mother's Date of Birth", motherDobCtl),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Spouse Name (If Applicable)",
                    spouseNameCtl,
                    hint: "Enter Spouse Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField(
                    "Spouse's Date of Birth (If Applicable)",
                    spouseDobCtl,
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "First Child's Name (If Applicable)",
                    firstChildNameCtl,
                    hint: "Enter First Child's Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField(
                    "First Child's Date of Birth (If Applicable)",
                    firstChildDobCtl,
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Second Child's Name (If Applicable)",
                    secondChildNameCtl,
                    hint: "Enter Second Child's Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField(
                    "Second Child's Date of Birth (If Applicable)",
                    secondChildDobCtl,
                  ),
                  const SizedBox(height: 21),

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
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => EditSavedDialog(),
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
                        "Next",
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
