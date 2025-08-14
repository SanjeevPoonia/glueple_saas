import 'package:flutter/material.dart';
import 'package:glueplenew/profile/edit_education_details.dart';
import 'package:lottie/lottie.dart';
import '../widget/appbar.dart';

class EducationDetailScreen extends StatefulWidget {
  final dynamic profiledata;
  const EducationDetailScreen({super.key, this.profiledata});

  @override
  State<EducationDetailScreen> createState() => _EducationDetailScreen();
}

class _EducationDetailScreen extends State<EducationDetailScreen> {
  var profiledata;

  @override
  void initState() {
    super.initState();
    profiledata = widget.profiledata;
  }

  // Keeping generic getter removed since unused in this screen

  List<dynamic> _getEducationList() {
    final data = profiledata;
    if (data == null) return const [];
    final dynamic list = data['education_details'];
    if (list is List) return list;
    return const [];
  }

  List<Widget> _buildEducationSections() {
    final list = _getEducationList();
    if (list.isEmpty) {
      return [
        Text(
          "No education details",
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ];
    }

    final List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      final item = list[i] as Map<String, dynamic>? ?? {};
      widgets.addAll([
        Text(
          "Details ${i + 1}",
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        const SizedBox(height: 4),
        _buildRow("Emp Educational Class", (item['class'] ?? '-').toString()),
        const Divider(),
        _buildRow("Emp Roll No.", (item['roll_no'] ?? '-').toString()),
        const Divider(),
        _buildRow("Smp School", (item['school'] ?? '-').toString()),
        const Divider(),
        _buildRow("Emp Board", (item['board'] ?? '-').toString()),
        const Divider(),
        _buildRow("Emp Percentage", (item['percentage'] ?? '-').toString()),
        const Divider(),
        _buildRow("Year", (item['year'] ?? '-').toString()),
        const Divider(),
        const SizedBox(height: 8),
      ]);
    }
    return widgets;
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEducationDetails(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "assets/education.png",
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
                                          "Education Details",
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
                              SizedBox(height: 8),

                              ..._buildEducationSections(),
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
