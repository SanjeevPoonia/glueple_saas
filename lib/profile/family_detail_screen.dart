import 'package:flutter/material.dart';
import 'package:glueplenew/profile/edit_family_details.dart';
import 'package:glueplenew/profile/profile_edit_details.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar.dart';

class FamilyDetailScreen extends StatefulWidget {
  const FamilyDetailScreen({super.key});

  @override
  State<FamilyDetailScreen> createState() => _FamilyDetailScreen();
}

class _FamilyDetailScreen extends State<FamilyDetailScreen> {
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
                                  builder: (context) => EditFamilyDetails(),
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
                                          "assets/family.png",
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
                                          "Family Details",
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
                              Divider(),
                              _buildRow("Emp User Id", "973"),
                              Divider(),
                              _buildRow("Emp Father Name", "Lorem Ipsum"),
                              Divider(),
                              _buildRow("Emp Father Dob", "2000-08-14"),
                              Divider(),
                              _buildRow("Emp Mother Name", "Lorem Ipsum"),
                              Divider(),
                              _buildRow("Emp Mother Dob", "2000-08-14"),
                              Divider(),
                              _buildRow("Emp Spouse Name", "-"),
                              Divider(),
                              _buildRow("Emp Spouse Dob", "-"),
                              Divider(),
                              _buildRow("Emp Spouse Aadhar Card No", "-"),
                              Divider(),
                              _buildRow("Emp First Child Name", "-"),
                              Divider(),
                              _buildRow("Emp First Child Dob", "-"),
                              Divider(),
                              _buildRow("Emp Second Child Name", "-"),
                              Divider(),
                              _buildRow("Emp Second Child Dob", "-"),
                              Divider(),
                              _buildRow("Emp Details Tag Id", "2"),
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
