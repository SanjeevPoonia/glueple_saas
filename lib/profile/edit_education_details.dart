import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class EditEducationDetails extends StatefulWidget {
  const EditEducationDetails({super.key});

  @override
  State<EditEducationDetails> createState() => _EditEducationDetails();
}

class _EditEducationDetails extends State<EditEducationDetails> {
  final List<String> boardOptions = ['CBSE', 'RBSE', 'ICSE', 'Other'];
  String? selectedBoard;

  final TextEditingController rollNoCtl = TextEditingController();
  final TextEditingController percentageCtl = TextEditingController();

  final List<String> yearOptions = [
    for (int y = DateTime.now().year; y >= 1980; y--) y.toString(),
  ];
  String? selectedYear;

  String? tenthMarksheetFileName;
  String? twelfthMarksheetFileName;
  String? graduationMarksheetFileName;

  Future<void> filepicker(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      setState(() {
        if (type == '10th') {
          tenthMarksheetFileName = fileName;
        } else if (type == '12th') {
          twelfthMarksheetFileName = fileName;
        } else if (type == 'graduation') {
          graduationMarksheetFileName = fileName;
        }
      });
    }
  }

  Widget buildDropdownField(
    String label,
    String? value,
    List<String> options,
    void Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        items: options
            .map(
              (option) => DropdownMenuItem(value: option, child: Text(option)),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

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
                    "Education Details",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Education',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Board",
                          selectedBoard,
                          boardOptions,
                          (val) => setState(() => selectedBoard = val),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                "Roll No",
                                rollNoCtl,
                                hint: "Enter Roll No",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildTextField(
                                "Percentage",
                                percentageCtl,
                                hint: "Enter %",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Year",
                          selectedYear,
                          yearOptions,
                          (val) => setState(() => selectedYear = val),
                        ),
                        const SizedBox(height: 12),

                        // File upload field
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: tenthMarksheetFileName != null
                                    ? Text(
                                        tenthMarksheetFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload 10th Marksheet',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('10th'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('10th'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secondary Education',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Board",
                          selectedBoard,
                          boardOptions,
                          (val) => setState(() => selectedBoard = val),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                "Roll No",
                                rollNoCtl,
                                hint: "Enter Roll No",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildTextField(
                                "Percentage",
                                percentageCtl,
                                hint: "Enter %",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Year",
                          selectedYear,
                          yearOptions,
                          (val) => setState(() => selectedYear = val),
                        ),
                        const SizedBox(height: 12),

                        // File upload field
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: tenthMarksheetFileName != null
                                    ? Text(
                                        tenthMarksheetFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload 12th Marksheet',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('12th'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('12th'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Graduation',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Board",
                          selectedBoard,
                          boardOptions,
                          (val) => setState(() => selectedBoard = val),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                "Roll No",
                                rollNoCtl,
                                hint: "Enter Roll No",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildTextField(
                                "Percentage",
                                percentageCtl,
                                hint: "Enter %",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        buildDropdownField(
                          "Year",
                          selectedYear,
                          yearOptions,
                          (val) => setState(() => selectedYear = val),
                        ),
                        const SizedBox(height: 12),

                        // File upload field
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: tenthMarksheetFileName != null
                                    ? Text(
                                        tenthMarksheetFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload Graduation Marksheet',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('graduation'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('graduation'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 3),
                            ],
                            color: Color(0xFF1B81A4),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Add More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 10),
                            ],
                            color: Color(0xFF00C797),
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
                                vertical: 16,
                              ),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
