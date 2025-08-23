import 'package:flutter/material.dart';
import 'package:glueplenew/profile/document_upload_screen.dart';
import 'package:glueplenew/profile/edit_bank_details.dart';
import 'package:glueplenew/profile/edit_basic_personal_details.dart';
import 'package:glueplenew/profile/edit_basic_workexp.dart';
import 'package:glueplenew/profile/edit_education_details.dart';
import 'package:glueplenew/profile/edit_family_details.dart';
import 'package:glueplenew/profile/edit_id_card_details.dart';
import 'package:glueplenew/profile/edit_personal_details.dart';
import 'package:glueplenew/profile/edit_reference_details.dart';
import 'package:glueplenew/profile/edit_social_details.dart';
import 'package:glueplenew/profile/edit_workexp_details.dart';
import 'package:glueplenew/profile/id_card_details_dialog.dart';
import 'package:glueplenew/profile/policy_detail_screen.dart';
import 'package:glueplenew/profile/upload_document_details.dart';
import '../widget/appbar.dart';

class ProfileEditPage extends StatefulWidget {
  final dynamic profiledata;
  final String token;
  final String baseUrl;

  ProfileEditPage({
    required this.profiledata,
    required this.token,
    required this.baseUrl,
  });

  @override
  State<ProfileEditPage> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  var profiledata;

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

  Widget _screenForStep(String shortName) {
    switch (shortName) {
      case 'Personal Details':
        return EditBasicPersonalDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Family Details':
        return EditFamilyDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Education Details':
        return EditEducationDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Bank Details':
        return EditBankDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Social Details':
        return EditSocialDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Reference Details':
        return EditReferenceDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Work Experience Details':
        return EditWorkExp(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'Upload Documents':
        return EditDocumentUploadDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      case 'ID Card Details':
        return EditIdCardDetails(
          profiledata: profiledata,
          token: widget.token,
          baseUrl: widget.baseUrl,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  final List<Map<String, dynamic>> sections = [
    {"title": "Personal Details", "icon": "personal.png", "progress": 1.0},
    {"title": "Family Details", "icon": "family.png", "progress": 1.0},
    {"title": "Education Details", "icon": "education.png", "progress": 1.0},
    {"title": "Bank Details", "icon": "bank.png", "progress": 1.0},
    {"title": "Social Details", "icon": "reference.png", "progress": 0.7},
    {"title": "Reference Details", "icon": "reference.png", "progress": 0.7},
    {
      "title": "Work Experience Details",
      "icon": "reference.png",
      "progress": 0.7,
    },
    {"title": "Upload Documents", "icon": "document.png", "progress": 1.0},
    {"title": "ID Card Details", "icon": "idcard.png", "progress": 0.7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'My Profile',
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

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sections.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    _screenForStep(section['title']),
                              ),
                            );
                          },
                          child: _buildProgressCard(
                            title: section['title'],
                            iconPath: 'assets/${section['icon']}',
                            progress: section['progress'],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String iconPath,
    required double progress,
  }) {
    final progressPercent = (progress * 100).toInt();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(33, 0, 199, 152),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              iconPath,
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Status',
                  style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 9,
                          backgroundColor: Color(0xFFE1E9EE),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress == 1.0
                                ? Color(0xFF1D963A)
                                : Color(0xFF1B81A4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$progressPercent%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
