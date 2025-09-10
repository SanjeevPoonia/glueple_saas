import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/edit_personal_details.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:intl/intl.dart';

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({super.key});

  @override
  State<CreateNewTicket> createState() => _CreateNewTicket();
}

class _CreateNewTicket extends State<CreateNewTicket> {
  final TextEditingController fullNameCtl = TextEditingController();
  final TextEditingController dobCtl = TextEditingController();
  final TextEditingController mobileCtl = TextEditingController();
  final TextEditingController personalEmailCtl = TextEditingController();
  final TextEditingController alternateEmailCtl = TextEditingController();
  final TextEditingController emergencyMobileNoCtl = TextEditingController();
  String? helptopic = "Select";
  String? issuetype = "Select";
  String? issuesubtype = "Select";
  TextEditingController subjectCtl = TextEditingController(text: "Enter here");
  String? userimpact = "Select";
  String? prioritylevel = "Select";
  TextEditingController issueDetailsCtl = TextEditingController(
    text: "Enter here",
  );

  String? selectedGender;
  String? selectedMaritalStatus;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> maritalStatusOptions = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  Widget buildDropdownField(
    String label,
    String? value,
    List<String> options,
    String? hint,
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
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const Spacer(),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            items: options
                .map(
                  (option) =>
                      DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
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
        title: 'Ticket Management System',
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
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
                    "Create Ticket",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please select your Help Topic",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildProcessField(
                    "Help Topic",
                    helptopic,
                    (val) => setState(() => helptopic = val),
                    HelpTopicDialog(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please select Your Issue Type",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildProcessField(
                    "Issue Type",
                    issuetype,
                    (val) => setState(() => issuetype = val),
                    IssueTypeDialog(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please select Your Issue Sub Type",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildProcessField(
                    "Issue Sub Type",
                    issuesubtype,
                    (val) => setState(() => issuesubtype = val),
                    IssueSubType(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please enter Subject",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildTextField("Subject", subjectCtl, hint: subjectCtl.text),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "${subjectCtl.text.length}/500 char",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please select Count Of User Impacted",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildProcessField(
                    "Count Of User Impacted",
                    userimpact,
                    (val) => setState(() => userimpact = val),
                    UserImpactDialog(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please select Priority Level",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildProcessField(
                    "Priority Level",
                    prioritylevel,
                    (val) => setState(() => prioritylevel = val),
                    PriorityLevelDialog(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Please Enter Details About Issue",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  buildTextField(
                    "Issue Details",
                    issueDetailsCtl,
                    hint: issueDetailsCtl.text,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "${issueDetailsCtl.text.length}/500 char",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // buildDateField("Date of Birth", dobCtl),
                  // const SizedBox(height: 12),
                  // buildDropdownField(
                  //   "Gender",
                  //   selectedGender,
                  //   genderOptions,
                  //   "Select",
                  //   (val) => setState(() => selectedGender = val),
                  // ),
                  // const SizedBox(height: 12),
                  // buildDropdownField(
                  //   "Marital Status",
                  //   selectedMaritalStatus,
                  //   maritalStatusOptions,
                  //   "Select",
                  //   (val) => setState(() => selectedMaritalStatus = val),
                  // ),
                  // const SizedBox(height: 12),
                  // buildTextField(
                  //   "Mobile Number",
                  //   mobileCtl,
                  //   hint: "Enter Mobile Number",
                  // ),
                  // const SizedBox(height: 12),
                  // buildTextField(
                  //   "Personal Email",
                  //   personalEmailCtl,
                  //   hint: "Enter Personal Email",
                  // ),
                  // const SizedBox(height: 12),
                  // buildTextField(
                  //   "Alternate Email",
                  //   alternateEmailCtl,
                  //   hint: "Enter Alternate Email",
                  // ),
                  // const SizedBox(height: 12),
                  // buildTextField(
                  //   "Emergency Mobile No.",
                  //   emergencyMobileNoCtl,
                  //   hint: "Enter Emergency Mobile No.",
                  // ),
                  // const SizedBox(height: 21),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                ),
                              ],
                              color: Color(0xFF1B81A4),
                            ),
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => TicketCreatedSuccess(),
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
                                "Create Ticket",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                ),
                              ],
                              color: Color(0xFF00C797),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => TicketStatusScreen(),
                                //   ),
                                // );
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
                                "Reset",
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProcessField(
    String label,
    String? selectedValue,
    Function(String) onSelected,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => screen,
        );

        if (result != null) {
          onSelected(result);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F7FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Color(0xFF707070)),
                ),
                Text(
                  selectedValue ?? label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedValue == null ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class HelpTopicDialog extends StatelessWidget {
  HelpTopicDialog({super.key});
  final List<String> helpTopicOptions = [
    "IT Support Related",
    "HR Related",
    "Finance Related",
    "Admin Related",
    "Training Related",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Help Topic",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "New"),
                  child: const Text(
                    "IT Support Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Replacement"),
                  child: const Text(
                    "HR Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Replacement"),
                  child: const Text(
                    "Finance Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Replacement"),
                  child: const Text(
                    "Admin Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Replacement"),
                  child: const Text(
                    "Training Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
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
                      Navigator.pop(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IssueTypeDialog extends StatelessWidget {
  IssueTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Issue Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "Cosec Related"),
                  child: const Text(
                    "Cosec Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Headphone Related"),
                  child: const Text(
                    "Headphone Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "Keyboard/Mouse Related"),
                  child: const Text(
                    "Keyboard/Mouse Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Internet Down"),
                  child: const Text(
                    "Internet Down",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "System issue"),
                  child: const Text(
                    "System issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Application issue"),
                  child: const Text(
                    "Application issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "MS Office related issue"),
                  child: const Text(
                    "MS Office related issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Calling issues"),
                  child: const Text(
                    "Calling issues",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Samparq Related"),
                  child: const Text(
                    "Samparq Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "Porter Application Related"),
                  child: const Text(
                    "Porter Application Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "VI Application Related"),
                  child: const Text(
                    "VI Application Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "VPN related issue"),
                  child: const Text(
                    "VPN related issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "VPN Not Connecting"),
                  child: const Text(
                    "VPN Not Connecting",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    "Remote Desktop Connectivity Issue",
                  ),
                  child: const Text(
                    "Remote Desktop Connectivity Issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    "Hardware/Desktop/Laptop Part Issue",
                  ),
                  child: const Text(
                    "Hardware/Desktop/Laptop Part Issue",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Email Related"),
                  child: const Text(
                    "Email Related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "System Down"),
                  child: const Text(
                    "System Down",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),

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
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IssueSubType extends StatelessWidget {
  const IssueSubType({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Issue Sub Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    "New User Configured & Login in Mobile",
                  ),
                  child: const Text(
                    "New User Configured & Login in Mobile",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    "Forget Cosec ID & password related",
                  ),
                  child: const Text(
                    "Forget Cosec ID & password related",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "Cosec Attandance not showing"),
                  child: const Text(
                    "Cosec Attandance not showing",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    "User not open to login cosec link System OR Laptop",
                  ),
                  child: const Text(
                    "User not open to login cosec link System OR Laptop",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, "Others (Cosec Related)"),
                  child: const Text(
                    "Others (Cosec Related)",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),

                SizedBox(height: 20),
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
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserImpactDialog extends StatelessWidget {
  const UserImpactDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Count of user Impacted",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "1"),
                  child: const Text(
                    "1",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "2"),
                  child: const Text(
                    "2",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "3"),
                  child: const Text(
                    "3",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "4"),
                  child: const Text(
                    "4",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "5"),
                  child: const Text(
                    "5",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "More than 5"),
                  child: const Text(
                    "More than 5",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                SizedBox(height: 20),
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
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriorityLevelDialog extends StatelessWidget {
  const PriorityLevelDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Priority Level",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "Critical"),
                  child: const Text(
                    "Critical",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "High"),
                  child: const Text(
                    "High",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Medium"),
                  child: const Text(
                    "Medium",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Low"),
                  child: const Text(
                    "Low",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),

                SizedBox(height: 20),
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
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketCreatedSuccess extends StatefulWidget {
  const TicketCreatedSuccess({super.key});

  @override
  State<TicketCreatedSuccess> createState() => _TicketCreatedSuccess();
}

class _TicketCreatedSuccess extends State<TicketCreatedSuccess> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.50,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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

                Image.asset(
                  'assets/run_with_time.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 18),
                Text(
                  "New Ticket Created\nSuccessfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),

                Row(
                  children: [
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
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
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
