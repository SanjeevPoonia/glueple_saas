import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/edit_personal_details.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';

class EditBasicPersonalDetails extends StatefulWidget {
  final dynamic profiledata;
  final String token;
  final String baseUrl;

  EditBasicPersonalDetails({
    required this.profiledata,
    required this.token,
    required this.baseUrl,
  });

  @override
  State<EditBasicPersonalDetails> createState() => _EditBasicPersonalDetails();
}

class _EditBasicPersonalDetails extends State<EditBasicPersonalDetails> {
  var profiledata;
  final TextEditingController fullNameCtl = TextEditingController();
  final TextEditingController dobCtl = TextEditingController();
  final TextEditingController mobileCtl = TextEditingController();
  final TextEditingController personalEmailCtl = TextEditingController();
  final TextEditingController alternateEmailCtl = TextEditingController();
  final TextEditingController emergencyMobileNoCtl = TextEditingController();

  String? selectedGender;
  String? selectedMaritalStatus;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> maritalStatusOptions = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  String _getEmployeeName() {
    final data = profiledata;
    if (data == null) return 'N/A';
    final String name = (data['name'] ?? '').toString().trim();
    if (name.isNotEmpty) return name;
    final String first = (data['first_name'] ?? '').toString().trim();
    final String last = (data['last_name'] ?? '').toString().trim();
    final String full = [first, last].where((s) => s.isNotEmpty).join(' ');
    return full.isEmpty ? 'N/A' : full;
  }

  String _getFieldValue(String key) {
    final data = profiledata;
    if (data == null) return 'N/A';
    final dynamic value = data[key];
    if (value == null) return 'N/A';
    final String stringValue = value.toString();
    if (stringValue.trim().isEmpty) return 'N/A';
    return stringValue;
  }

  @override
  void initState() {
    super.initState();
    getprofileData();
    fullNameCtl.text = _getEmployeeName();
    dobCtl.text = _getFieldValue('dob');
    mobileCtl.text = _getFieldValue('mobile');
    personalEmailCtl.text = _getFieldValue('personal_email');
    alternateEmailCtl.text = _getFieldValue('alternate_email');
    emergencyMobileNoCtl.text = _getFieldValue('emergency_mobile_no');
  }

  void getprofileData() {
    if (widget.profiledata != null) {
      setState(() {
        profiledata = widget.profiledata;
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
                    "Personal Details",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Full Name",
                    fullNameCtl,
                    hint: "Enter Full Name",
                  ),
                  const SizedBox(height: 12),
                  buildDateField("Date of Birth", dobCtl),
                  const SizedBox(height: 12),
                  buildDropdownField(
                    "Gender",
                    selectedGender,
                    genderOptions,
                    (val) => setState(() => selectedGender = val),
                  ),
                  const SizedBox(height: 12),
                  buildDropdownField(
                    "Marital Status",
                    selectedMaritalStatus,
                    maritalStatusOptions,
                    (val) => setState(() => selectedMaritalStatus = val),
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Mobile Number",
                    mobileCtl,
                    hint: "Enter Mobile Number",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Personal Email",
                    personalEmailCtl,
                    hint: "Enter Personal Email",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Alternate Email",
                    alternateEmailCtl,
                    hint: "Enter Alternate Email",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Emergency Mobile No.",
                    emergencyMobileNoCtl,
                    hint: "Enter Emergency Mobile No.",
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
                        // Collect data from controllers and dropdowns
                        List<dynamic> personaldata = [
                          fullNameCtl.text,
                          dobCtl.text,
                          selectedGender,
                          selectedMaritalStatus,
                          mobileCtl.text,
                          personalEmailCtl.text,
                          alternateEmailCtl.text,
                          emergencyMobileNoCtl.text,
                        ];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPersonalDetails(
                              profiledata: profiledata,
                              personaldata: personaldata,
                              token: widget.token,
                              baseUrl: widget.baseUrl,
                              onPhotoUploaded: (String) {},
                            ),
                          ),
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
