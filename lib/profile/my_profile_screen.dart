import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/network/Utils.dart';
import 'package:glueplenew/network/api_dialog.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:glueplenew/profile/bank_detail_screen.dart';
import 'package:glueplenew/profile/document_upload_screen.dart';
import 'package:glueplenew/profile/edit_workexp_details.dart';
import 'package:glueplenew/profile/education_detail_screen.dart';
import 'package:glueplenew/profile/family_detail_screen.dart';
import 'package:glueplenew/profile/personal_detail_screen.dart';
import 'package:glueplenew/profile/policy_detail_screen.dart';
import 'package:glueplenew/profile/profile_edit_details.dart';
import 'package:glueplenew/profile/profile_photo_dialog.dart';
import 'package:glueplenew/profile/reference_detail_screen.dart';
import 'package:glueplenew/profile/social_detail_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import '../widget/appbar.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
  bool isLoading = false;
  late var userIdStr;
  late var fullNameStr;
  late var designationStr;
  late var token;
  late var empId;
  late var baseUrl;
  // ignore: prefer_typing_uninitialized_variables
  var profileData;

  var clientCode = "";

  String employeeIdStr = "";
  String NameStr = "";
  String joiningDate = "";
  String mobileNoStr = "";
  String emailStr = "";
  String departmentStr = "";
  String desiStr = "";
  String reportingManager = "";

  int offerLaterStatus = 0;
  int offerRejectedStatus = 0;
  int personalDetailsStatus = 0;
  int familyDetailsStatus = 0;
  int educationDetailsStatus = 0;
  int bankDetailsStatus = 0;
  int socialDetailsStatus = 0;
  int workExperienceDetailsStatus = 0;
  int referenceDetailsStatus = 0;
  int empPolicyDetyailsStatus = 0;
  int documentDetailsStatus = 0;

  String profileImage = "";

  XFile? imageFile;
  File? file;
  bool sectionsLoading = true;

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My\nProfile",
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                height: 1, // Reduce line spacing
                              ),
                            ),
                            // Add animation(assets/Automation.json)
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Lottie.asset(
                                  'assets/Automation.json',
                                  repeat: true,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
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
                                    child:
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.circular(12),
                                        //   child: Image.network(
                                        //     "https://randomuser.me/api/portraits/men/75.jpg",
                                        //     height: 55,
                                        //     width: 55,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            // _showAlertDialog();
                                          },
                                          child: profileImage == ""
                                              ? CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                    "assets/profile.png",
                                                  ),
                                                  radius: 55,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12.0,
                                                      ),
                                                  child: Image.network(
                                                    profileImage,
                                                    width: 55,
                                                    height: 55,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                  ),
                                  const SizedBox(width: 12),

                                  // 👇 Correct layout: No nested Row
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          NameStr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          desiStr,
                                          style: TextStyle(
                                            color: Color(0xFF00C797),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            ProfilePhotoDialog(),
                                      );
                                    },
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Color(0xFF00C797),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(),
                              _buildRow("Employee ID", employeeIdStr),
                              Divider(),
                              _buildRow("Joining Date", joiningDate),
                              Divider(),
                              _buildRow("Mobile No.", mobileNoStr),
                              Divider(),
                              _buildRow("Email", emailStr),
                              Divider(),
                              _buildRow("Department", departmentStr),
                              Divider(),
                              _buildRow("Reporting Manager", reportingManager),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.maxFinite,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditPage(),
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
                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PolicyDetailScreen(
                                baseUrl: baseUrl,
                                token: token,
                                clientCode: clientCode,
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
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
                                    "assets/idcard.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Policies",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        'Company Policies',
                                        style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // In your ListView.separated, wrap it with:
                        sectionsLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF00C797),
                                ),
                              )
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: sections.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final section = sections[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (section['dialog'] != null) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              section['dialog'],
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                section['screen'],
                                          ),
                                        );
                                      }
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  // Replace this hardcoded list
  List<Map<String, dynamic>> sections = [];

  // Add this configuration map instead (only static values here)
  final Map<String, Map<String, dynamic>> sectionConfig = {
    "personal_details": {"icon": "personal.png"},
    "family_details": {"icon": "family.png"},
    "education_details": {"icon": "education.png"},
    "bank_details": {"icon": "bank.png"},
    "social_details": {"icon": "social.png"},
    "reference_details": {"icon": "reference.png"},
    "work_experience_details": {"icon": "reference.png"},
    "upload_documents": {"icon": "document.png"},
  };

  Widget _screenForStep(String shortName) {
    switch (shortName) {
      case 'personal_details':
        return PersonalDetailScreen(profiledata: profileData);
      case 'family_details':
        return FamilyDetailScreen(profiledata: profileData);
      case 'education_details':
        return EducationDetailScreen(profiledata: profileData);
      case 'bank_details':
        return BankDetailScreen(profiledata: profileData);
      case 'social_details':
        return SocialDetailScreen(profiledata: profileData);
      case 'reference_details':
        return ReferenceDetailScreen(profiledata: profileData);
      case 'work_experience_details':
        return EditWorkExp(profiledata: profileData);
      case 'upload_documents':
        return DocumentUploadScreen(profiledata: profileData);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      _getDashboardData();
    });
  }

  _getDashboardData() async {
    setState(() {
      isLoading = true;
      sectionsLoading = true;
    });
    APIDialog.showAlertDialog(context, 'Please Wait...');
    userIdStr = await MyUtils.getSharedPreferences("user_id");
    fullNameStr = await MyUtils.getSharedPreferences("full_name");
    token = await MyUtils.getSharedPreferences("token");
    designationStr = await MyUtils.getSharedPreferences("designation");
    empId = await MyUtils.getSharedPreferences("emp_id");
    baseUrl = await MyUtils.getSharedPreferences("base_url");
    clientCode = await MyUtils.getSharedPreferences("client_code") ?? "";
    Navigator.of(context).pop();
    await getUserProfile();
    await getOnboardingSteps();
  }

  getUserProfile() async {
    // Don't show another loading dialog since we already have one
    ApiBaseHelper helper = ApiBaseHelper();
    try {
      var response = await helper.getWithToken(
        baseUrl,
        'get-profile',
        token,
        clientCode,
        context,
      );

      var responseJSON = json.decode(response.body);
      print("Profile Response: $responseJSON");

      // Updated condition to match the actual API response
      if (responseJSON['code'] == 200 && responseJSON['data'] != null) {
        List<dynamic> tempList = responseJSON['data'];
        if (tempList.isNotEmpty) {
          profileData = tempList[0];

          // Map the API response fields to your variables
          employeeIdStr = profileData['emp_id']?.toString() ?? "";

          // Handle name from the API response
          if (profileData['name'] != null) {
            NameStr = profileData['name'].toString();
          } else if (profileData['first_name'] != null) {
            NameStr = profileData['first_name'].toString();
            if (profileData['last_name'] != null) {
              NameStr = "$NameStr ${profileData['last_name']}";
            }
          }

          // Format joining date
          if (profileData['joining_date'] != null) {
            try {
              var dateTime = DateTime.parse(profileData['joining_date']);
              joiningDate = DateFormat("MMM d, yyyy").format(dateTime);
            } catch (e) {
              joiningDate = profileData['joining_date'].toString();
            }
          }

          mobileNoStr =
              profileData['personal_mobile']?.toString() ??
              profileData['mobile']?.toString() ??
              "";
          emailStr =
              profileData['personal_email']?.toString() ??
              profileData['email']?.toString() ??
              "";
          departmentStr = profileData['department_name']?.toString() ?? "";
          desiStr = profileData['designation_name']?.toString() ?? "";
          reportingManager = profileData['reported_to_name']?.toString() ?? "";

          // Handle profile image if available
          if (profileData['profile_image'] != null) {
            profileImage = profileData['profile_image'].toString();
          }
        }

        setState(() {
          isLoading = false;
        });
      } else {
        Toast.show(
          responseJSON['message'] ?? "Something went wrong",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      Toast.show(
        "Network error occurred",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  getOnboardingSteps() async {
    ApiBaseHelper helper = ApiBaseHelper();
    try {
      var response = await helper.getWithToken(
        baseUrl,
        'get-onboarding-step?view_profile=true',
        token,
        clientCode,
        context,
      );

      var responseJSON = json.decode(response.body);
      print("Onboarding Steps Response: $responseJSON");

      if (responseJSON['code'] == 200 && responseJSON['data'] != null) {
        List<dynamic> stepsList = responseJSON['data'];

        // Sort by sort_order from API
        stepsList.sort(
          (a, b) => (a['sort_order'] ?? 0).compareTo(b['sort_order'] ?? 0),
        );

        List<Map<String, dynamic>> tempSections = [];

        for (var step in stepsList) {
          final shortName = step['short_name'];
          if (!sectionConfig.containsKey(shortName))
            continue; // Skip unknown steps

          final config = sectionConfig[shortName]!;

          // Calculate progress properly
          double progressValue = 0.0;
          if (step.containsKey('completion_percentage')) {
            progressValue = (step['completion_percentage'] ?? 0) / 100.0;
          } else {
            // Fallback: use is_active status
            progressValue = step['is_active'] == true ? 1.0 : 0.0;
          }

          tempSections.add({
            "title": step['name'] ?? "",
            "icon": config['icon'],
            "progress": progressValue,
            "screen": _screenForStep(shortName),
            "dialog": config['dialog'], // Will be null if not set
          });
        }

        setState(() {
          sections = tempSections;
          sectionsLoading = false; // Add this line
        });
      } else {
        Toast.show(
          responseJSON['message'] ?? "Something went wrong",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Error fetching onboarding steps: $e");
      Toast.show(
        "Network error occurred",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
    }
  }
}
