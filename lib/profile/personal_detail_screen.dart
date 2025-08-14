import 'package:flutter/material.dart';
import 'package:glueplenew/profile/edit_basic_personal_details.dart';
// import 'package:glueplenew/profile/profile_edit_details.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar.dart';

// ignore: must_be_immutable
class PersonalDetailScreen extends StatefulWidget {
  final dynamic profiledata;
  PersonalDetailScreen({required this.profiledata});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreen();
}

class _PersonalDetailScreen extends State<PersonalDetailScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var profiledata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'My Profile',
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.maxFinite,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditBasicPersonalDetails(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(double.maxFinite, 60),
                              side: const BorderSide(
                                color: Color(0xFF00C797),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/Edit.json',
                                  repeat: true,
                                  fit: BoxFit.contain,
                                ),
                                Spacer(),
                                const Text(
                                  'Edit Documents',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00C797),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(33, 0, 199, 152),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/personal.png",
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Personal Details",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'QD2204',
                                          style: TextStyle(
                                            color: Color(0xFF00C797),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              _buildRow("Emp Name", _getEmployeeName()),
                              Divider(),
                              _buildRow("Emp's DOB", _getFieldValue('dob')),
                              Divider(),
                              _buildRow(
                                "Emp's Gender",
                                _getFieldValue('gender'),
                              ),
                              Divider(),
                              _buildRow(
                                "Marital Status",
                                _getFieldValue('marital_status'),
                              ),
                              Divider(),
                              _buildRow(
                                "Present Address Street",
                                _getFieldValue('present_address'),
                              ),
                              Divider(),
                              _buildRow(
                                "Present Address City",
                                _getFieldValue('present_city'),
                              ),
                              Divider(),
                              _buildRow(
                                "Present Address State",
                                _getFieldValue('present_state'),
                              ),
                              Divider(),
                              _buildRow(
                                "Present Address Postal Code",
                                _getFieldValue('present_postal_code'),
                              ),
                              Divider(),
                              _buildRow(
                                "Permanent Address Street",
                                _getFieldValue('permanent_address'),
                              ),
                              Divider(),
                              _buildRow(
                                "Permanent Address City",
                                _getFieldValue('permanent_city'),
                              ),
                              Divider(),
                              _buildRow(
                                "Permanent Address State",
                                _getFieldValue('permanent_state'),
                              ),
                              Divider(),
                              _buildRow(
                                "Permanent Address Postal Code",
                                _getFieldValue('permanent_postal_code'),
                              ),
                              Divider(),
                              _buildRow(
                                "Emp Mobile",
                                _getFirstNonEmpty([
                                  'personal_mobile',
                                  'mobile',
                                ]),
                              ),
                              Divider(),
                              _buildRow(
                                "Personal Email",
                                _getFirstNonEmpty(['personal_email', 'email']),
                              ),
                              Divider(),
                              _buildRow(
                                "Alternate Email",
                                _getFieldValue('alternate_email'),
                              ),
                              Divider(),
                              _buildRow("Emp UAN No", _getFieldValue('uan_no')),
                              Divider(),
                              _buildRow(
                                "Emp ESIC No",
                                _getFieldValue('esic_no'),
                              ),
                              Divider(),
                              _buildRow(
                                "Emp Aadhar Card",
                                _getFieldValue('aadhar_no'),
                              ),
                              Divider(),
                              _buildRow(
                                "Emp PAN Card",
                                _getFieldValue('pan_no'),
                              ),
                              Divider(),
                              _buildRow(
                                "Emergency Mobile",
                                _getFieldValue('emergency_mobile'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
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

  @override
  void initState() {
    super.initState();
    getprofileData();
  }

  void getprofileData() {
    if (widget.profiledata != null) {
      setState(() {
        profiledata = widget.profiledata;
      });
    }
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

  String _getFirstNonEmpty(List<String> keys) {
    for (final key in keys) {
      final value = _getFieldValue(key);
      if (value != 'N/A') return value;
    }
    return 'N/A';
  }

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

  Widget _buildRow(String month, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            month,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          // Spacer(),
          Text(
            value.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            // textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
