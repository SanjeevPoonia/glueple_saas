import 'package:flutter/material.dart';
import 'package:glueplenew/profile/profile_edit_details.dart';
import 'package:glueplenew/profile/profile_photo_dialog.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        "https://randomuser.me/api/portraits/men/75.jpg",
                                        height: 55,
                                        width: 55,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // 👇 Correct layout: No nested Row
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "John Smith",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Junior UI Developer',
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
                              _buildRow("Employee ID", "QD2204"),
                              Divider(),
                              _buildRow("Joining Date", "2022-03-22"),
                              Divider(),
                              _buildRow("Mobile No.", 98765432101),
                              Divider(),
                              _buildRow("Email", "johnsmith@qdegrees.org"),
                              Divider(),
                              _buildRow("Department", "Product Development"),
                              Divider(),
                              _buildRow("Reporting Manager", "Kristen Johnson"),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
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
                                        builder: (context) => ProfileEditPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit Documents',
                                    style: TextStyle(
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
                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 12),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sections.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final section = sections[index];
                            return _buildProgressCard(
                              title: section['title'],
                              iconPath: 'assets/${section['icon']}',
                              progress: section['progress'],
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
}
