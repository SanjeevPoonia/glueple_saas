import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';

class EditReferenceDetails extends StatefulWidget {
  final dynamic profiledata;
  final String token;
  final String baseUrl;
  EditReferenceDetails({
    required this.profiledata,
    required this.token,
    required this.baseUrl,
  });

  @override
  State<EditReferenceDetails> createState() => _EditReferenceDetails();
}

class _EditReferenceDetails extends State<EditReferenceDetails> {
  var profiledata;
  final TextEditingController firstrefnameCtl = TextEditingController();
  final TextEditingController firstrefcontactCtl = TextEditingController();
  final TextEditingController firstrefemailCtl = TextEditingController();

  final TextEditingController secondrefnameCtl = TextEditingController();
  final TextEditingController secondrefcontactCtl = TextEditingController();
  final TextEditingController secondrefemailCtl = TextEditingController();

  bool isLoading = false;

  void saveOnboardingData() async {
    setState(() => isLoading = true);

    ApiBaseHelper helper = ApiBaseHelper();

    final fieldMappings = {
      "first_reference_name": firstrefnameCtl.text,
      "first_reference_no": firstrefcontactCtl.text,
      "first_reference_email": firstrefemailCtl.text,
      "second_reference_name": secondrefnameCtl.text,
      "second_reference_no": secondrefcontactCtl.text,
      "second_reference_email": secondrefemailCtl.text,
    };

    var apiParams = {"query_type": "reference_details"};

    fieldMappings.forEach((dataKey, value) {
      if (value.toString().isNotEmpty) {
        apiParams[dataKey] = value.toString();
      }
    });

    try {
      var rawResponse = await helper.postAPIWithHeader(
        widget.baseUrl,
        'save-onboarding-details',
        apiParams,
        context,
        widget.token,
      );

      var response = jsonDecode(rawResponse.body);

      if (response['success'] == true) {
        Navigator.of(context).pop();
      } else {
        debugPrint("Save failed: ${response['errorMessage']}");
        // Show error to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save: ${response['errorMessage']}"),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error saving personal details: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred while saving")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getprofileData();

    // Initialize reference fields
    final refs = _getReferenceList();
    if (refs.isNotEmpty) {
      final ref = refs[0]; // Get first reference
      firstrefnameCtl.text = ref['first_reference_name'];
      firstrefcontactCtl.text = ref['first_reference_no'];
      firstrefemailCtl.text = ref['first_reference_email'];
      secondrefnameCtl.text = ref['second_reference_name'];
      secondrefcontactCtl.text = ref['second_reference_no'];
      secondrefemailCtl.text = ref['second_reference_email'];
    }
  }

  void getprofileData() {
    if (widget.profiledata != null) {
      setState(() {
        profiledata = widget.profiledata;
      });
    }
  }

  // String _getFieldValue(String key) {
  //   if (profiledata == null) return 'N/A';
  //   final dynamic value = profiledata[key];
  //   if (value == null) return 'N/A';
  //   final String stringValue = value.toString();
  //   if (stringValue.trim().isEmpty) return 'N/A';
  //   return stringValue;
  // }

  List<Map<String, dynamic>> _getReferenceList() {
    if (profiledata == null) return [];

    // Get the reference_details array from profiledata
    final dynamic refDetails = profiledata['reference_details'];

    // If it's not a list or is empty, return empty list
    if (refDetails is! List || refDetails.isEmpty) {
      return [];
    }

    // Map the data to a more usable format
    return refDetails.map<Map<String, dynamic>>((ref) {
      return {
        'first_reference_name': ref['first_reference_name'] ?? '',
        'first_reference_no': ref['first_reference_no'] ?? '',
        'first_reference_email': ref['first_reference_email'] ?? '',
        'second_reference_name': ref['second_reference_name'] ?? '',
        'second_reference_no': ref['second_reference_no'] ?? '',
        'second_reference_email': ref['second_reference_email'] ?? '',
      };
    }).toList();
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
                    "Reference Details",
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
                          'First Reference',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        buildTextField("Name", firstrefnameCtl, hint: "-"),
                        const SizedBox(height: 10),
                        buildTextField(
                          "Contact",
                          firstrefcontactCtl,
                          hint: "-",
                        ),
                        const SizedBox(height: 10),
                        buildTextField("Email", firstrefemailCtl, hint: "-"),
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

                        buildTextField("Name", secondrefnameCtl, hint: "-"),
                        const SizedBox(height: 10),
                        buildTextField(
                          "Contact",
                          secondrefcontactCtl,
                          hint: "-",
                        ),
                        const SizedBox(height: 10),
                        buildTextField("Email", secondrefemailCtl, hint: "-"),
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
                              BoxShadow(color: Colors.black26, blurRadius: 10),
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              saveOnboardingData();
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
