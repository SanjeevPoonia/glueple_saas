import 'package:flutter/material.dart';
import 'package:glueplenew/dialogs/password_required_dialog.dart';
import 'package:glueplenew/taskbox/more_dialog.dart';
import 'package:glueplenew/taskbox/select_year_dialog.dart';
import '../widget/appbar.dart';
import 'package:intl/intl.dart';

class PayslipPreviewScr extends StatefulWidget {
  const PayslipPreviewScr({super.key});

  @override
  State<PayslipPreviewScr> createState() => _PayslipPreviewScr();
}

class _PayslipPreviewScr extends State<PayslipPreviewScr> {
  int year = 2023;
  final List<Map<String, dynamic>> earnings = const [
    {'label': 'BASIC', 'full': 14375.0, 'actual': 12375.0},
    {'label': 'HRA', 'full': 7188.0, 'actual': 5188.0},
    {'label': 'SPECIAL AL', 'full': 1600.0, 'actual': 1600.0},
    {'label': 'LTA RELM', 'full': 1250.0, 'actual': 1250.0},
    {'label': 'EDU ALLOW', 'full': 200.0, 'actual': 200.0},
  ];

  final double deduction = 1400.0;

  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹ ');
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final fullTotal = earnings.fold<double>(0, (sum, e) => sum + e['full']);
    final actualTotal = earnings.fold<double>(0, (sum, e) => sum + e['actual']);
    final fullFinal = fullTotal - deduction;
    final actualFinal = actualTotal - deduction;
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
                              _buildRow("Emp Id", "QD1234"),
                              Divider(),
                              _buildRow("Employee Name", "Rohan Mehta"),
                              Divider(),
                              _buildRow("Pay Days", 30),
                              Divider(),
                              _buildRow("Present Days", 22),
                              Divider(),
                              _buildRow("Designation", "Senior Developer"),
                              Divider(),
                              _buildRow("Location", "Jaipur"),
                              Divider(),
                              _buildRow("Adhaar Number", "123456789123"),
                              Divider(),
                              _buildRow("Date of Birth", "03/01/1995"),
                              Divider(),
                              _buildRow("PAN Number", "BXY124579HV"),
                              Divider(),
                              _buildRow("Bank A/c No.", 56230124897541),
                              Divider(),
                              _buildRow("Absent Days", 0),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F7FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                _buildRoww(
                                  "Earnings",
                                  "Full",
                                  "Actual",
                                  isHeader: true,
                                ),
                                const Divider(),
                                for (var e in earnings)
                                  _buildRoww(
                                    e['label'],
                                    formatCurrency(e['full']),
                                    formatCurrency(e['actual']),
                                  ),
                                const Divider(),
                                _buildRoww(
                                  "Total",
                                  formatCurrency(fullTotal),
                                  formatCurrency(actualTotal),
                                  isBold: true,
                                ),
                                const SizedBox(height: 8),
                                _buildRoww(
                                  "Deduction",
                                  formatCurrency(deduction),
                                  formatCurrency(deduction),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      95,
                                      0,
                                      199,
                                      152,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 12,
                                  ),
                                  child: _buildRoww(
                                    "Final Amount",
                                    formatCurrency(fullFinal),
                                    formatCurrency(actualFinal),
                                    isBold: true,
                                  ),
                                ),
                              ],
                            ),
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

Widget _buildRoww(
  String label,
  String full,
  String actual, {
  bool isHeader = false,
  bool isBold = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isHeader || isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            full,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isHeader || isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            actual,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isHeader || isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          month,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Spacer(),
        Container(
          width: 150,
          child: Text(
            value.toString(),
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
