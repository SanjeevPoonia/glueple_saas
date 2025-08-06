import 'package:flutter/material.dart';
import 'package:glueplenew/dialogs/password_required_dialog.dart';
import '../widget/appbar.dart';

class PayslipDownloadScr extends StatefulWidget {
  const PayslipDownloadScr({super.key});

  @override
  State<PayslipDownloadScr> createState() => _PayslipDownloadScr();
}

class _PayslipDownloadScr extends State<PayslipDownloadScr> {
  int year = 2023;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Payslip',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),

                        Text(
                          "December 2023",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildRow("January $year", context),
                              Divider(),
                              _buildRow("February $year", context),
                              Divider(),
                              _buildRow("March $year", context),
                              Divider(),
                              _buildRow("April $year", context),
                              Divider(),
                              _buildRow("May $year", context),
                              Divider(),
                              _buildRow("June $year", context),
                              Divider(),
                              _buildRow("July $year", context),
                              Divider(),
                              _buildRow("August $year", context),
                              Divider(),
                              _buildRow("September $year", context),
                              Divider(),
                              _buildRow("October $year", context),
                              Divider(),
                              _buildRow("November $year", context),
                              Divider(),
                              _buildRow("December $year", context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRow(String month, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          month,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => PassRequiredDialog(),
            );
          },
          child: Icon(
            Icons.downloading_outlined,
            size: 22,
            color: Color(0xFF00C797),
          ),
        ),
      ],
    ),
  );
}
