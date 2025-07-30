import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glueplenew/widget/appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_theme.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ApplyLeave_Screen extends StatefulWidget {
  _applyLeaveState createState() => _applyLeaveState();
}

class _applyLeaveState extends State<ApplyLeave_Screen> {
  String dateRageStr = "Please Select Date Range";

  String fromDateStr = "Select From Date";
  String toDateStr = "Select To Date";
  double leaveBalanceStr = 0;
  String selectedLeaveTypeKey = '';

  String fromDate = "";
  String toDate = "";
  String dropdownvalue = '';
  List<String> items = [];
  var fromDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
  String fromDropDownValue = 'Full Day';
  var toDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
  String toDropDownValue = 'Full Day';

  bool isLoading = false;
  late var userIdStr;
  late var fullNameStr;
  late var designationStr;
  late var token;
  late var empId;
  late var baseUrl;
  late var platform;
  late var clientCode;

  List<dynamic> leaveTypeList = [];
  List<dynamic> leaveBalanceList = [];

  final _formKey = GlobalKey<FormState>();
  var reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Apply Leave',
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center()
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From Date",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    _showFromDatePicker();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: AppTheme.greyColor,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            fromDateStr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        SvgPicture.asset(
                                          'assets/at_calendar.svg',
                                          height: 21,
                                          width: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Leave Status",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: AppTheme.greyColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: DropdownButton(
                                    items: fromDateItem.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        fromDropDownValue = newValue!;
                                      });
                                    },
                                    value: fromDropDownValue,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppTheme.themeColor,
                                      size: 15,
                                    ),
                                    isExpanded: true,
                                    underline: SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To Date",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    _showEndDateValidation();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: AppTheme.greyColor,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            toDateStr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        SvgPicture.asset(
                                          'assets/at_calendar.svg',
                                          height: 21,
                                          width: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Leave Status",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: AppTheme.greyColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: DropdownButton(
                                    items: toDateItem.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        toDropDownValue = newValue!;
                                      });
                                    },
                                    value: toDropDownValue,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppTheme.themeColor,
                                      size: 15,
                                    ),
                                    isExpanded: true,
                                    underline: SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Leave Type",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: AppTheme.greyColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: DropdownButton(
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                      checkTheLeaveBalance();
                                    },
                                    value: dropdownvalue,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppTheme.themeColor,
                                      size: 15,
                                    ),
                                    isExpanded: true,
                                    underline: SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Leave Balance",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: AppTheme.greyColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${leaveBalanceStr.toString()}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text(
                        "Reason",
                        style: TextStyle(
                          fontSize: 14.5,
                          color: AppTheme.themeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: AppTheme.greyColor,
                              width: 2.0,
                            ),
                          ),
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            controller: reasonController,
                            maxLength: 500,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          applyLeave();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.orangeColor,
                          ),
                          height: 45,
                          padding: const EdgeInsets.all(10),
                          child: const Center(
                            child: Text(
                              "Submit For Approval",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _showFromDatePicker() async {
    var nowDate = DateTime.now();
    var lastDate = DateTime(nowDate.year, nowDate.month + 2, 1);
    var firstDate = DateTime(nowDate.year, nowDate.month - 1, 1);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      fromDate = DateFormat("yyyy-MM-dd").format(pickedDate);
      setState(() {
        fromDateStr = fromDate;
      });
    }
  }

  _showEndDatePicker() async {
    var nowDate = DateFormat("yyyy-MM-dd").parse(fromDate);
    var lastDate = DateTime(nowDate.year, nowDate.month, nowDate.day + 6);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: nowDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      toDate = DateFormat("yyyy-MM-dd").format(pickedDate);

      var fDate = DateFormat("dd MMM yyyy").format(nowDate);
      var tDate = DateFormat("dd MMM yyyy").format(pickedDate);

      setState(() {
        dateRageStr = "$fDate To $tDate";
        toDateStr = toDate;
      });
    }
  }

  _showEndDateValidation() {
    if (fromDate.isEmpty) {
      Toast.show(
        "Please Select From Date First!!!",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
    } else {
      _showEndDatePicker();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      _buildListItems();
    });
  }

  _buildListItems() async {
    APIDialog.showAlertDialog(context, "Please Wait...");
    setState(() {
      isLoading = true;
    });
    userIdStr = await MyUtils.getSharedPreferences("user_id");
    fullNameStr = await MyUtils.getSharedPreferences("full_name");
    token = await MyUtils.getSharedPreferences("token");
    designationStr = await MyUtils.getSharedPreferences("designation");
    empId = await MyUtils.getSharedPreferences("emp_id");
    baseUrl = await MyUtils.getSharedPreferences("base_url");
    clientCode = await MyUtils.getSharedPreferences("client_code");

    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    } else {
      platform = "Other";
    }
    Navigator.pop(context);
    setState(() {
      isLoading = false;
    });

    getLeaveType();
  }

  getLeaveType() async {
    setState(() {
      isLoading = true;
    });
    APIDialog.showAlertDialog(context, 'Please Wait...');
    try {
      String baseUrl = await MyUtils.getSharedPreferences("base_url") ?? "";
      String token = await MyUtils.getSharedPreferences("token") ?? "";
      String clientCode =
          await MyUtils.getSharedPreferences("client_code") ?? "";

      ApiBaseHelper helper = ApiBaseHelper();
      var response = await helper.getWithToken(
        baseUrl,
        "get-leave-balance",
        token,
        clientCode,
        context,
      );
      Navigator.pop(context);
      var responseJSON = json.decode(response.body);
      print(responseJSON);
      if (responseJSON['code'] == 200) {
        leaveTypeList.clear();
        leaveTypeList = responseJSON['data'];
        items.clear();

        var firstposi = true;
        for (int i = 0; i < leaveTypeList.length; i++) {
          String leaveType = leaveTypeList[i]['leave_name'].toString();
          String leavekey = leaveTypeList[i]['leave_type'].toString();
          if (leavekey != "short_leave") {
            items.add(leaveType);
            if (firstposi) {
              dropdownvalue = leaveType;
              selectedLeaveTypeKey = leavekey;
              firstposi = false;
            }
            checkTheLeaveBalance();
          }
        }
        setState(() {
          isLoading = false;
        });

        if (items.isEmpty) {
          Toast.show(
            "Leave Type Not Found!!!!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red,
          );
          _finishTheScreen();
        } else {
          getLeaveBalance();
        }
      } else {
        Toast.show(
          responseJSON['message'] ?? "Failed to load leave types",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
        );

        setState(() {
          isLoading = false;
        });

        _finishTheScreen();
      }
    } catch (e) {
      Navigator.pop(context);
      print("Error fetching leave types: $e");
      Toast.show(
        "Network error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      setState(() {
        isLoading = false;
      });
      _finishTheScreen();
    }
  }

  getLeaveBalance() async {
    setState(() {
      isLoading = true;
    });
    APIDialog.showAlertDialog(context, 'Please Wait...');
    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.getWithToken(
      baseUrl,
      'get-leave-balance',
      token,
      clientCode!,
      context,
    );
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    if (responseJSON['code'] == 200) {
      leaveBalanceList.clear();
      leaveBalanceList = responseJSON['data'];

      for (int i = 0; i < leaveBalanceList.length; i++) {
        String leaveType = leaveBalanceList[i]['leave_type'].toString();
        if (selectedLeaveTypeKey == leaveType) {
          leaveBalanceStr = 0;
          if (leaveBalanceList[i]['leave_balance'] != null) {
            leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
          }
          break;
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  _finishTheScreen() {
    Navigator.of(context).pop();
  }

  checkTheLeaveBalance() async {
    for (int i = 0; i < leaveTypeList.length; i++) {
      String leaveType = leaveTypeList[i]['leave_name'].toString();
      String leavekey = leaveTypeList[i]['leave_type'].toString();
      if (leaveType == dropdownvalue) {
        selectedLeaveTypeKey = leavekey;
        break;
      }
    }

    print("Selected Leave Type Key : $selectedLeaveTypeKey");

    for (int i = 0; i < leaveBalanceList.length; i++) {
      String leaveType = leaveBalanceList[i]['leave_type'].toString();
      print("Leave Type Key : $leaveType");
      if (selectedLeaveTypeKey == leaveType) {
        leaveBalanceStr = 0;
        if (leaveBalanceList[i]['leave_balance'] != null) {
          leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
        }
        break;
      } else {
        leaveBalanceStr = 0;
      }
    }
    print("leaveBalanceStr : $leaveBalanceStr");

    setState(() {});
  }

  applyLeave() async {
    APIDialog.showAlertDialog(context, 'Please Wait...');
    ApiBaseHelper helper = ApiBaseHelper();
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? empId = sp.getString("emp_id");
    String? token = sp.getString("token");
    var detailArray = [];

    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      if (fromDate == toDate) {
        var requestModel = {
          "leave_date": fromDate,
          "leave_type": selectedLeaveTypeKey,
          "leave_status": fromDropDownValue,
        };
        detailArray.add(requestModel);
      } else {
        DateTime fDate = DateFormat("yyyy-MM-dd").parse(fromDate);
        DateTime tDate = DateFormat("yyyy-MM-dd").parse(toDate);
        int diffrence = tDate.difference(fDate).inDays;

        if (diffrence > 1) {
          List<DateTime> days = getDaysInBetween(fDate, tDate);

          var requestModelfrom = {
            "leave_date": fromDate,
            "leave_type": selectedLeaveTypeKey,
            "leave_status": fromDropDownValue,
          };
          detailArray.add(requestModelfrom);

          days.forEach((day) {
            String date = day.toString().split(' ')[0];
            String leaveType = selectedLeaveTypeKey;
            String leaveStatus = "Full Day";
            var requestModeldyn = {
              "leave_date": date,
              "leave_type": leaveType,
              "leave_status": leaveStatus,
            };
            detailArray.add(requestModeldyn);
          });

          var requestModelto = {
            "leave_date": toDate,
            "leave_type": selectedLeaveTypeKey,
            "leave_status": toDropDownValue,
          };
          detailArray.add(requestModelto);
        } else if (diffrence == 1) {
          var requestModelfrom = {
            "leave_date": fromDate,
            "leave_type": selectedLeaveTypeKey,
            "leave_status": fromDropDownValue,
          };
          var requestModelto = {
            "leave_date": toDate,
            "leave_type": selectedLeaveTypeKey,
            "leave_status": toDropDownValue,
          };
          detailArray.add(requestModelfrom);
          detailArray.add(requestModelto);
        }
      }
    }

    var request = {
      "emp_id": empId,
      "leave_start_date": fromDate,
      "leave_end_date": toDate,
      "reason": reasonController.text.toString(),
      "leave_details": detailArray,
    };

    try {
      var response = await helper.postAPIWithHeader(
        baseUrl,
        'apply-leave',
        request,
        context,
        token!,
      );
      Navigator.pop(context);
      var responseJSON = response; // Use the response directly
      if (responseJSON['code'] == 200) {
        Toast.show(
          responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
        );
        Navigator.pop(context, true);
      } else {
        Toast.show(
          responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      print("Error applying for leave: $e");
      Toast.show(
        "Network error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
    }
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 1; i <= endDate.difference(startDate).inDays - 1; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
}
