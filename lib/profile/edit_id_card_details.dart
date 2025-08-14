import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/profile/id_card_details_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';

class EditIdCardDetails extends StatefulWidget {
  const EditIdCardDetails({super.key});

  @override
  State<EditIdCardDetails> createState() => _EditIdCardDetails();
}

class _EditIdCardDetails extends State<EditIdCardDetails> {
  final TextEditingController empIdCtl = TextEditingController();
  final TextEditingController bloodGrpCtl = TextEditingController();
  final TextEditingController emergencyNoCtl = TextEditingController();
  final TextEditingController contactNoCtl = TextEditingController();
  String? profilePhoto;
  Future<void> filepicker(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      setState(() {
        profilePhoto = fileName;
      });
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
                    "ID Card Details",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          "Blood Group",
                          bloodGrpCtl,
                          hint: "-",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildTextField(
                          "Employee ID",
                          empIdCtl,
                          hint: "-",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  buildTextField("Emergency No.", emergencyNoCtl, hint: "-"),
                  const SizedBox(height: 12),

                  buildTextField("Contact No.", contactNoCtl, hint: "-"),

                  const SizedBox(height: 12),

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
                          child: profilePhoto != null
                              ? Text(
                                  profilePhoto!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profile Photo',
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
                                              filepicker('profilePhoto'),
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
                          onPressed: () => filepicker('profilePhoto'),
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
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => IDCardDetailsDialog(),
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
                              "Preview",
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
