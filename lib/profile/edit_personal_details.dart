import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({super.key});

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetails();
}

class _EditPersonalDetails extends State<EditPersonalDetails> {
  // Blood group and IDs
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  String? selectedBloodGroup;
  final TextEditingController uanCtl = TextEditingController();
  final TextEditingController esicCtl = TextEditingController();

  // Permanent Address
  final TextEditingController permPlotCtl = TextEditingController();
  final TextEditingController permCityCtl = TextEditingController();
  final TextEditingController permJaipurCtl = TextEditingController();
  final TextEditingController permStateCtl = TextEditingController();
  final TextEditingController permRajasthanCtl = TextEditingController();
  final TextEditingController permPostalCtl = TextEditingController();

  final TextEditingController presPlotCtl = TextEditingController();
  final TextEditingController presCityCtl = TextEditingController();
  final TextEditingController presJaipurCtl = TextEditingController();
  final TextEditingController presStateCtl = TextEditingController();
  final TextEditingController presRajasthanCtl = TextEditingController();
  final TextEditingController presPostalCtl = TextEditingController();

  // Checkbox
  bool sameAsPermanent = false;

  void copyPermanentToPresent() {
    presPlotCtl.text = permPlotCtl.text;
    presCityCtl.text = permCityCtl.text;
    presJaipurCtl.text = permJaipurCtl.text;
    presStateCtl.text = permStateCtl.text;
    presRajasthanCtl.text = permRajasthanCtl.text;
    presPostalCtl.text = permPostalCtl.text;
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
                    "Personal Details",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                  // Blood Group, UAN, ESIC
                  buildDropdownField(
                    "Blood Group",
                    selectedBloodGroup,
                    bloodGroups,
                    (val) => setState(() => selectedBloodGroup = val),
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Existing UAN No. (If Any)",
                    uanCtl,
                    hint: "Enter UAN No.",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Existing ESIC No. (If Any)",
                    esicCtl,
                    hint: "Enter ESIC No.",
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 1.2),
                  const SizedBox(height: 10),

                  // Permanent Address
                  Text(
                    'Permanent Address',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 10),
                  buildTextField(
                    "Plot No/Street/Colony",
                    permPlotCtl,
                    hint: "Enter Plot/Street/Colony",
                  ),
                  const SizedBox(height: 12),
                  buildTextField("City", permCityCtl, hint: "Enter City"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          "Jaipur",
                          permJaipurCtl,
                          hint: "Jaipur",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTextField(
                          "State",
                          permStateCtl,
                          hint: "State",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Rajasthan",
                    permRajasthanCtl,
                    hint: "Rajasthan",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Postal Code",
                    permPostalCtl,
                    hint: "Enter Postal Code",
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 1.2),
                  const SizedBox(height: 10),

                  // Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: sameAsPermanent,
                        onChanged: (val) {
                          setState(() {
                            sameAsPermanent = val ?? false;
                            if (sameAsPermanent) copyPermanentToPresent();
                          });
                        },
                      ),
                      const Text("Present Address same as Permanent Address"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 1.2),
                  const SizedBox(height: 10),

                  buildTextField(
                    "Plot No/Street/Colony",
                    presPlotCtl,
                    hint: "Enter Plot/Street/Colony",
                  ),
                  const SizedBox(height: 12),
                  buildTextField("City", presCityCtl, hint: "Enter City"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          "Jaipur",
                          presJaipurCtl,
                          hint: "Jaipur",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTextField(
                          "State",
                          presStateCtl,
                          hint: "State",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Rajasthan",
                    presRajasthanCtl,
                    hint: "Rajasthan",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Postal Code",
                    presPostalCtl,
                    hint: "Enter Postal Code",
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
                            color: Colors.grey.shade300,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                              "Back",
                              style: TextStyle(
                                color: Colors.black,
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
