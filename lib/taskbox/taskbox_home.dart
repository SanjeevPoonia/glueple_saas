import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glueplenew/authentication/logout_functionality.dart';
import 'package:glueplenew/network/Utils.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:glueplenew/taskbox/task_filter_dialog.dart';
import 'package:glueplenew/taskbox/create_task_screen.dart';
import 'package:glueplenew/taskbox/task_detail_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import '../widget/appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TaskBoxHome extends StatefulWidget {
  const TaskBoxHome({super.key});

  @override
  State<TaskBoxHome> createState() => _TaskBoxHome();
}

class _TaskBoxHome extends State<TaskBoxHome> {
  int taskselection = 0;
  bool attDashboardLoading = false;
  List<dynamic> taskList = [];

  String todayDateStr = "";
  int totalTasks = 0;
  int openTasks = 0;
  int reopenedTasks = 0;
  int closeTasks = 0;
  int toDoTasks = 0;
  int inProgressTasks = 0;
  int rejectedTasks = 0;
  int holdTasks = 0;

  var userIdStr = "";
  var designationStr = "";
  var token = "";
  var fullNameStr = "";
  var empId = "";
  var baseUrl = "";
  var clientCode = "";
  var platform = "";
  var isAttendanceAccess = "1";
  var firstName = "";
  var userProfile = "";

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Taskbox',
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: [
                            SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatCard(
                                  totalTasks.toString(),
                                  "Total\nTasks",
                                ),
                                _buildStatCard(
                                  openTasks.toString(),
                                  "Open\nTasks",
                                ),
                                _buildStatCard(
                                  reopenedTasks.toString(),
                                  "Responded\nTasks",
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatCard(
                                  closeTasks.toString(),
                                  "Close\nTasks",
                                ),
                                _buildStatCard(
                                  toDoTasks.toString(),
                                  "To Do\nTasks",
                                ),
                                _buildStatCard(
                                  inProgressTasks.toString(),
                                  "In Progress\nTasks",
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatCard(
                                  rejectedTasks.toString(),
                                  "Rejected\nTasks",
                                ),
                                _buildStatCard(
                                  holdTasks.toString(),
                                  "Hold\nTasks",
                                ),
                                Container(
                                  width: 110,
                                  padding: EdgeInsets.all(10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // More content...
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Task",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: double.maxFinite,
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 60),
                                  side: const BorderSide(
                                    color: Color(
                                      0xFF00C797,
                                    ), // Changed border color
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
                                      'assets/Add.json',
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
                                                CreateTaskScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Create',
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
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(children: [_buildAllTasksCard()]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, [Image? image]) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B81A4),
                ),
              ),
              Spacer(),
              if (image != null) image,
            ],
          ),
          SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTasksCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FAF6),
                  borderRadius: BorderRadius.circular(8),
                ),
                // padding: const EdgeInsets.all(8),
                child: Image.asset('assets/tasks.png', width: 36, height: 36),
              ),
              SizedBox(width: 10),
              Text(
                'All Tasks',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              Spacer(),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => TaskFilterBottomSheet(
                      token: token,
                      baseUrl: baseUrl,
                      clientCode: clientCode,
                      onApplyFilters: (filters) {
                        print("Selected Filters: $filters");
                        getTaskList(filters: filters); // Fetch filtered data
                      },
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt,
                        color: Color(0xFF1B81A4),
                        size: 20,
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Color(0xFF1B81A4),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8),
          // Three selection buttons with (All, Assigned Task, Watchers)
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    taskselection = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: taskselection == 0
                        ? Color(0xFF1B81A4)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'All',
                    style: TextStyle(
                      color: taskselection == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),

              GestureDetector(
                onTap: () {
                  setState(() {
                    taskselection = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: taskselection == 1
                        ? Color(0xFF1B81A4)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Assigned Task',
                    style: TextStyle(
                      color: taskselection == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    taskselection = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: taskselection == 2
                        ? Color(0xFF1B81A4)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Watchers',
                    style: TextStyle(
                      color: taskselection == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          if (taskList.isEmpty)
            Center(
              child: Text(
                'No tasks found',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                var task = taskList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildTaskItem(
                    task['task_code'] ?? '',
                    task['status_label'] ?? '',
                    Color(0xFF1D963A), // You can set based on status
                    task['task_project_label'] ?? '',
                    task['task_date'] ?? '',
                    task['due_date'] ?? '',
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    String id,
    String status,
    Color statusColor,
    String project,
    String taskDate,
    String dueDate,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF5FBFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top row with id and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Task ID:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 5),
                  Text(id, style: TextStyle(fontSize: 16)),
                ],
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
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8),
          // Project, task date, due date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Project'),
                  Text(
                    project,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Task Date'),
                  Text(
                    taskDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Due Date'),
                  Text(dueDate, style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskDetailScreen()),
            ),
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  'More',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF1B81A4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getUserData() async {
    userIdStr = await MyUtils.getSharedPreferences("user_id") ?? "";
    fullNameStr = await MyUtils.getSharedPreferences("full_name") ?? "";
    firstName = await MyUtils.getSharedPreferences("first_name") ?? "";
    token = await MyUtils.getSharedPreferences("token") ?? "";
    designationStr = await MyUtils.getSharedPreferences("designation") ?? "";
    empId = await MyUtils.getSharedPreferences("emp_id") ?? "";
    baseUrl = await MyUtils.getSharedPreferences("base_url") ?? "";
    clientCode = await MyUtils.getSharedPreferences("client_code") ?? "";
    String? access = await MyUtils.getSharedPreferences("at_access") ?? '1';
    userProfile = await MyUtils.getSharedPreferences("profile_img") ?? "";
    String? ratingDurationId =
        await MyUtils.getSharedPreferences("rating_duration_id") ?? "";
    isAttendanceAccess = access;
    print("Rating Duration Id:$ratingDurationId******************************");
    if (fullNameStr.isNotEmpty) {
      firstName = fullNameStr.split(" ")[0];
    }
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    } else {
      platform = "Other";
    }

    print("userId:-" + userIdStr.toString());
    print("token:-" + token.toString());
    print("employee_id:-" + empId.toString());
    print("Base Url:-" + baseUrl.toString());
    print("Platform:-" + platform);
    print("Client Code:-" + clientCode);

    var dateNow = DateTime.now();
    todayDateStr = DateFormat("dd MMM, yyyy").format(dateNow);
    print("Attendace Date $todayDateStr");
    getTaskDashData();
    getTaskList();
  }

  getTaskDashData() async {
    setState(() {
      attDashboardLoading = true;
    });

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.getWithToken(
      baseUrl,
      'task-status',
      token,
      clientCode,
      context,
    );

    var responseJSON = json.decode(response.body);
    print(responseJSON);

    if (responseJSON['success'] == true) {
      var data = responseJSON['data'];

      setState(() {
        totalTasks = data['total_count'] ?? 0;
        openTasks = data['open'] ?? 0;
        reopenedTasks = data['reopened'] ?? 0;
        closeTasks = data['close'] ?? 0;
        toDoTasks = data['to_do'] ?? 0;
        inProgressTasks = data['in_progress'] ?? 0;
        rejectedTasks = data['rejected'] ?? 0;
        holdTasks = data['hold'] ?? 0;

        attDashboardLoading = false;
      });
    } else if (responseJSON['code'] == 401 ||
        responseJSON['message'] == 'Invalid token.') {
      Toast.show(
        "Your Login session is Expired!! Please login again.",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      setState(() {
        attDashboardLoading = false;
      });
      LogoutUserFromApp.logOut(context);
    } else {
      Toast.show(
        responseJSON['message'],
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      setState(() {
        attDashboardLoading = false;
      });
    }
  }

  Future<void> getTaskList({Map<String, dynamic>? filters}) async {
    setState(() {
      attDashboardLoading = true;
    });

    ApiBaseHelper helper = ApiBaseHelper();

    // Prepare API parameters (POST body)
    final apiParams = {
      "employee_ids": (filters?['employees'] ?? []).join(','),
      "statuses": (filters?['statuses'] ?? []).join(','),
      "projects": (filters?['projects'] ?? []).join(','),
    };

    try {
      var response = await helper.postAPIWithHeader(
        baseUrl,
        'get-task',
        apiParams,
        context,
        token,
      );

      // `postAPIWithHeader` already decodes and handles errors,
      // so we can use the result directly
      if (response['success'] == true) {
        setState(() {
          taskList = response['data']['data'] ?? [];
          attDashboardLoading = false;
        });
      } else {
        setState(() {
          attDashboardLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching task list: $e");
      setState(() {
        attDashboardLoading = false;
      });
    }
  }
}
