import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glueplenew/network/Utils.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:intl/intl.dart';

import '../widget/appbar.dart';

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceDetailScreenState createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  bool isLoading = false;
  List<Map<String, String>> activities = [];
  late String token;
  late String empId;
  late String baseUrl;
  String? clientCode;

  int activePage = 0;
  static const int pageSize = 6;
  int get pageCount => ((activities.length + pageSize - 1) ~/ pageSize);
  List<Map<String, String>> get currentPageActivities {
    final start = activePage * pageSize;
    final end = (start + pageSize).clamp(0, activities.length);
    return activities.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();
    _loadPrefsAndFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Attendance',
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.category, size: 30, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : activities.isEmpty
          ? const Center(child: Text("No attendance data"))
          : Container(
              color: Colors.white,
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 300,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                          top: -40,
                                          left: -60,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              // gradient: const LinearGradient(
                                              // color: Color(0xFF00C797),
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              // ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(
                                                    0xFF00C797,
                                                  ).withOpacity(0.7),
                                                  blurRadius: 100,
                                                  spreadRadius: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 40,
                                          right: -40,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              // gradient: const LinearGradient(
                                              // color: Color(0xFF1B81A4),
                                              // begin: Alignment.topRight,
                                              // end: Alignment.bottomLeft,
                                              // ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(
                                                    0xFF1B81A4,
                                                  ).withOpacity(0.6),
                                                  blurRadius: 80,
                                                  spreadRadius: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 32,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 24),
                                            Text(
                                              'Today',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '19 Sept 2023',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 200,
                                      right: 0,
                                      top: 10,
                                      child: Center(
                                        child: Container(
                                          height: 170,
                                          width: 170,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/boyimg.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                16.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Activity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  _buildTimeline(),
                                                  const SizedBox(height: 16),
                                                  _buildPagination(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildTimeline() {
    final pageActivities = currentPageActivities;
    return Column(
      children: List.generate(pageActivities.length, (index) {
        final isLast = index == pageActivities.length - 1;
        final item = pageActivities[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade900,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 46,
                    color: const Color(0xFF00C797),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['label']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6FAF6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/facedetec.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item['time']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pageCount; i++)
          GestureDetector(
            onTap: () {
              if (activePage != i) {
                setState(() {
                  activePage = i;
                });
              }
            },
            child: _buildNumberedDot(i + 1, activePage == i),
          ),
      ],
    );
  }

  Widget _buildNumberedDot(int number, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1B81A4) : Colors.white,
        border: Border.all(color: const Color(0xFF1B81A4)),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF1B81A4),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _loadPrefsAndFetch() async {
    setState(() => isLoading = true);

    token = (await MyUtils.getSharedPreferences("token")) ?? "";
    empId = (await MyUtils.getSharedPreferences("employee_id")) ?? "";
    baseUrl = (await MyUtils.getSharedPreferences("base_url")) ?? "";
    clientCode = await MyUtils.getSharedPreferences("client_code") ?? "";

    await _fetchAttendanceLogs();
  }

  Future<void> _fetchAttendanceLogs() async {
    final helper = ApiBaseHelper();

    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final String endpoint =
        'get-attendance-logs'
        '?date=$today'
        '&emp_id=$empId';

    try {
      final response = await helper.getWithToken(
        baseUrl,
        endpoint,
        token,
        clientCode!,
        context,
      );

      final jsonBody = json.decode(response.body);
      if (jsonBody['code'] == 200 && jsonBody['data'] != null) {
        final List<dynamic> raw = jsonBody['data'];
        activities = raw.map<Map<String, String>>((item) {
          final source = item['device_from_name'] as String? ?? 'Unknown';

          final status = (item['log_type'] as String? ?? '').toUpperCase();

          final rawTs = item['punch_time'] as String? ?? '';
          DateTime? dt = DateTime.tryParse(rawTs);
          if (dt == null) {
            try {
              dt = DateFormat('yyyy-MM-dd HH:mm:ss').parse(rawTs);
            } catch (_) {
              /* ignore */
            }
          }
          final timeLabel = dt != null
              ? DateFormat('hh:mm a').format(dt)
              : rawTs;

          return {'label': '$source\n$status', 'time': timeLabel};
        }).toList();
        setState(() => isLoading = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonBody['message'] ?? 'Failed to load attendance'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }
}
