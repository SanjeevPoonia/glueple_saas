import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

import '../widget/appbar.dart';
import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_theme.dart';

class MyLeaveScreen extends StatefulWidget {
  const MyLeaveScreen({super.key});

  @override
  State<MyLeaveScreen> createState() => _MyLeaveScreen();
}

class _MyLeaveScreen extends State<MyLeaveScreen> {
  int selectedCenter = 0;
  bool isLoading = false;

  late var token;
  late var baseUrl;
  String? clientCode;

  List<dynamic> pendingLeaves = [];
  List<dynamic> approvedLeaves = [];
  List<dynamic> rejectedLeaves = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  _initializeData() async {
    setState(() {
      isLoading = true;
    });

    token = await MyUtils.getSharedPreferences("token");
    baseUrl = await MyUtils.getSharedPreferences("base_url");
    clientCode = await MyUtils.getSharedPreferences("client_code") ?? "";

    await _fetchLeaveData();

    setState(() {
      isLoading = false;
    });
  }

  _fetchLeaveData() async {
    await Future.wait<void>([
      _getLeaveList("pending"),
      _getLeaveList("approved"),
      _getLeaveList("rejected"),
    ]);
  }

  _getLeaveList(String status) async {
    try {
      ApiBaseHelper helper = ApiBaseHelper();
      var response = await helper.getWithToken(
        baseUrl,
        'get-employee-applied-leave?page=1&limit=50&request_for=applied&parameter=leave&status=$status',
        token,
        clientCode!,
        context,
      );

      var responseJSON = json.decode(response.body);
      print("$status leaves response: $responseJSON");

      if (responseJSON['code'] == 200 && responseJSON['data'] != null) {
        List<dynamic> leaveData = responseJSON['data']['data'] ?? [];

        setState(() {
          switch (status) {
            case "pending":
              pendingLeaves = leaveData;
              break;
            case "approved":
              approvedLeaves = leaveData;
              break;
            case "rejected":
              rejectedLeaves = leaveData;
              break;
          }
        });
      }
    } catch (e) {
      print("Error fetching $status leaves: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Leave Management',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              // Add notification logic
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
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF1B81A4)),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedCenter = 0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedCenter == 0
                                            ? Color(0xFF1B81A4)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Pending (${pendingLeaves.length})",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: selectedCenter == 0
                                                ? Colors.white
                                                : Color(0xFF1B81A4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedCenter = 1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedCenter == 1
                                            ? Color(0xFF1B81A4)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Approved/Rejected (${approvedLeaves.length + rejectedLeaves.length})",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: selectedCenter == 1
                                                ? Colors.white
                                                : Color(0xFF1B81A4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: selectedCenter == 0
                              ? _buildPendingLeaves()
                              : _buildApprovedRejectedLeaves(),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingLeaves() {
    if (pendingLeaves.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Icon(Icons.event_busy, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              "No Pending Leaves",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pendingLeaves.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        var leave = pendingLeaves[index];
        return _buildLeaveItem(leave, "pending");
      },
    );
  }

  Widget _buildApprovedRejectedLeaves() {
    List<dynamic> combinedLeaves = [...approvedLeaves, ...rejectedLeaves];

    if (combinedLeaves.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Icon(Icons.event_available, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              "No Approved/Rejected Leaves",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: combinedLeaves.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        var leave = combinedLeaves[index];
        String status = approvedLeaves.contains(leave)
            ? "approved"
            : "rejected";
        return _buildLeaveItem(leave, status);
      },
    );
  }

  Widget _buildLeaveItem(dynamic leave, String status) {
    String leaveType = leave['leave_short_name'] ?? 'N/A';
    String leaveDate = leave['leave_date'] ?? '';
    String reason = leave['reason'] ?? 'No reason provided';
    String leaveStatus = leave['leave_status'] ?? 'Full Day';

    // Format date
    String formattedDate = '';
    if (leaveDate.isNotEmpty) {
      try {
        DateTime dateTime = DateTime.parse(leaveDate);
        formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);
      } catch (e) {
        formattedDate = leaveDate;
      }
    }

    // Determine status color and text
    Color statusColor;
    String statusText;
    switch (status.toLowerCase()) {
      case 'pending':
        statusColor = Color(0xFFF5DD09);
        statusText = 'Pending';
        break;
      case 'approved':
        statusColor = Color(0xFF1D963A);
        statusText = 'Approved';
        break;
      case 'rejected':
        statusColor = Color(0xFFFF0000);
        statusText = 'Rejected';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF5FBFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF1B81A4).withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getLeaveTypeName(leaveType)} ($leaveType)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (reason != 'No reason provided' && reason.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          reason,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusText == 'Pending'
                        ? Colors.black
                        : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final boxWidth = constraints.constrainWidth();
                      final dashWidth = 4.0;
                      final dashSpace = 4.0;
                      final dashCount = (boxWidth / (dashWidth + dashSpace))
                          .floor();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(dashCount, (_) {
                          return Container(
                            width: dashWidth,
                            height: 1,
                            color: Colors.black,
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leaveStatus,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
              Text(
                '1 day',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getLeaveTypeName(String shortName) {
    switch (shortName.toUpperCase()) {
      case 'PL':
        return 'Paid Leave';
      case 'UPL':
        return 'Unpaid Leave';
      case 'SL':
        return 'Sick Leave';
      case 'CL':
        return 'Casual Leave';
      case 'ML':
        return 'Maternity Leave';
      case 'PTL':
        return 'Paternity Leave';
      default:
        return shortName;
    }
  }
}
