import 'package:flutter/material.dart';
import 'package:glueplenew/profile/profile_edit_details.dart';
import 'package:glueplenew/profile/upload_document_details.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar.dart';

class DocumentUploadScreen extends StatefulWidget {
  final dynamic profiledata;
  final String token;
  final String baseUrl;
  const DocumentUploadScreen({
    super.key,
    this.profiledata,
    required this.token,
    required this.baseUrl,
  });

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreen();
}

class _DocumentUploadScreen extends State<DocumentUploadScreen> {
  var profiledata;

  @override
  void initState() {
    super.initState();
    profiledata = widget.profiledata;
  }

  Map<String, dynamic> _getDocumentStatuses() {
    final data = profiledata;
    if (data == null) return {};
    final dynamic verify = data['verify_document'];
    if (verify is Map<String, dynamic>) return verify;
    return {};
  }

  String _statusText(dynamic value) {
    if (value == true ||
        (value is String && value.toLowerCase() == 'complete')) {
      return 'Complete';
    }
    if (value == false ||
        (value is String && value.toLowerCase() == 'pending')) {
      return 'Pending';
    }
    return value?.toString() ?? 'Pending';
  }

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
                            onPressed: () {},
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditDocumentUploadDetails(
                                              profiledata: profiledata,
                                              token: widget.token,
                                              baseUrl: widget.baseUrl,
                                            ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit Documents',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00C797),
                                    ),
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
                                          "assets/document.png",
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
                                          "Document Upload",
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

                              _buildRow(
                                "Aadhar Card",
                                _statusText(
                                  _getDocumentStatuses()['aadhar_card'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Pan Card",
                                _statusText(_getDocumentStatuses()['pan_card']),
                              ),
                              Divider(),
                              _buildRow(
                                "Driving License",
                                _statusText(
                                  _getDocumentStatuses()['driving_license'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Resume",
                                _statusText(_getDocumentStatuses()['resume']),
                              ),
                              Divider(),
                              _buildRow(
                                "Passport",
                                _statusText(_getDocumentStatuses()['passport']),
                              ),
                              Divider(),
                              _buildRow(
                                "Passport Size Photo",
                                _statusText(
                                  _getDocumentStatuses()['passport_photo'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "10th Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_10'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "12th Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_12'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "ITI Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_iti'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Diploma Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_diploma'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Graduation Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_graduation'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Post Graduation Marksheet",
                                _statusText(
                                  _getDocumentStatuses()['marksheet_post_graduation'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Bank Passbook",
                                _statusText(
                                  _getDocumentStatuses()['bank_passbook'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Previous Company Experience Letter",
                                _statusText(
                                  _getDocumentStatuses()['experience_letter'],
                                ),
                              ),
                              Divider(),
                              _buildRow(
                                "Previous Company Payslip",
                                _statusText(_getDocumentStatuses()['payslip']),
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

  Widget _buildRow(String value1, dynamic value2) {
    // Decide text color based on value2
    Color statusColor;
    if (value2.toString().trim().toLowerCase() == "complete") {
      statusColor = const Color(0xFF1D963A); // Green
    } else if (value2.toString().trim().toLowerCase() == "pending") {
      statusColor = const Color(0xFF8588A8); // Gray
    } else {
      statusColor = Colors.black; // Default color
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value1,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          Text(
            value2.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
