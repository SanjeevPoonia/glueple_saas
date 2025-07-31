// // import 'dart:convert';

// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:glueplenew/widget/appbar.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:toast/toast.dart';
// // import '../network/Utils.dart';
// // import '../network/api_dialog.dart';
// // import '../network/api_helper.dart';
// // import '../utils/app_theme.dart';
// // import 'package:intl/intl.dart';
// // import 'dart:io';

// // class ApplyLeave_Screen extends StatefulWidget {
// //   _applyLeaveState createState() => _applyLeaveState();
// // }

// // class _applyLeaveState extends State<ApplyLeave_Screen> {
// //   String dateRageStr = "Please Select Date Range";

// //   String fromDateStr = "Select From Date";
// //   String toDateStr = "Select To Date";
// //   double leaveBalanceStr = 0;
// //   String selectedLeaveTypeKey = '';

// //   String fromDate = "";
// //   String toDate = "";
// //   String dropdownvalue = '';
// //   List<String> items = [];
// //   var fromDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
// //   String fromDropDownValue = 'Full Day';
// //   var toDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
// //   String toDropDownValue = 'Full Day';

// //   bool isLoading = false;
// //   late var userIdStr;
// //   late var fullNameStr;
// //   late var designationStr;
// //   late var token;
// //   late var empId;
// //   late var baseUrl;
// //   late var platform;
// //   late var clientCode;

// //   List<dynamic> leaveTypeList = [];
// //   List<dynamic> leaveBalanceList = [];

// //   final _formKey = GlobalKey<FormState>();
// //   var reasonController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     ToastContext().init(context);
// //     return Scaffold(
// //       appBar: CustomAppBar(
// //         title: 'Apply Leave',
// //         leading: GestureDetector(
// //           onTap: () => Navigator.pop(context),
// //           child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
// //         ),
// //       ),
// //       body: isLoading
// //           ? const Center()
// //           : ListView(
// //               children: [
// //                 Padding(
// //                   padding: EdgeInsets.all(10),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "From Date",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 10),
// //                                 InkWell(
// //                                   onTap: () {
// //                                     _showFromDatePicker();
// //                                   },
// //                                   child: Container(
// //                                     width: double.infinity,
// //                                     height: 45,
// //                                     padding: EdgeInsets.all(5),
// //                                     decoration: BoxDecoration(
// //                                       shape: BoxShape.rectangle,
// //                                       border: Border.all(
// //                                         color: AppTheme.greyColor,
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     child: Row(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.center,
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.center,
// //                                       children: [
// //                                         Expanded(
// //                                           child: Text(
// //                                             fromDateStr,
// //                                             style: TextStyle(
// //                                               color: Colors.black,
// //                                               fontSize: 14.5,
// //                                               fontWeight: FontWeight.w500,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         SizedBox(width: 5),
// //                                         SvgPicture.asset(
// //                                           'assets/at_calendar.svg',
// //                                           height: 21,
// //                                           width: 18,
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           SizedBox(width: 5),
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               children: [
// //                                 Text(
// //                                   "Leave Status",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 10),
// //                                 Container(
// //                                   width: double.infinity,
// //                                   height: 45,
// //                                   padding: const EdgeInsets.only(
// //                                     left: 5,
// //                                     right: 5,
// //                                     top: 5,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     shape: BoxShape.rectangle,
// //                                     border: Border.all(
// //                                       color: AppTheme.greyColor,
// //                                       width: 2.0,
// //                                     ),
// //                                   ),
// //                                   child: DropdownButton(
// //                                     items: fromDateItem.map((String items) {
// //                                       return DropdownMenuItem(
// //                                         value: items,
// //                                         child: Text(items),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (String? newValue) {
// //                                       setState(() {
// //                                         fromDropDownValue = newValue!;
// //                                       });
// //                                     },
// //                                     value: fromDropDownValue,
// //                                     icon: Icon(
// //                                       Icons.keyboard_arrow_down,
// //                                       color: AppTheme.themeColor,
// //                                       size: 15,
// //                                     ),
// //                                     isExpanded: true,
// //                                     underline: SizedBox(),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "To Date",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 10),
// //                                 InkWell(
// //                                   onTap: () {
// //                                     _showEndDateValidation();
// //                                   },
// //                                   child: Container(
// //                                     width: double.infinity,
// //                                     height: 45,
// //                                     padding: EdgeInsets.all(5),
// //                                     decoration: BoxDecoration(
// //                                       shape: BoxShape.rectangle,
// //                                       border: Border.all(
// //                                         color: AppTheme.greyColor,
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     child: Row(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.center,
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.center,
// //                                       children: [
// //                                         Expanded(
// //                                           child: Text(
// //                                             toDateStr,
// //                                             style: TextStyle(
// //                                               color: Colors.black,
// //                                               fontSize: 14.5,
// //                                               fontWeight: FontWeight.w500,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         SizedBox(width: 5),
// //                                         SvgPicture.asset(
// //                                           'assets/at_calendar.svg',
// //                                           height: 21,
// //                                           width: 18,
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           SizedBox(width: 5),
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               children: [
// //                                 Text(
// //                                   "Leave Status",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 10),
// //                                 Container(
// //                                   width: double.infinity,
// //                                   height: 45,
// //                                   padding: const EdgeInsets.only(
// //                                     left: 5,
// //                                     right: 5,
// //                                     top: 5,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     shape: BoxShape.rectangle,
// //                                     border: Border.all(
// //                                       color: AppTheme.greyColor,
// //                                       width: 2.0,
// //                                     ),
// //                                   ),
// //                                   child: DropdownButton(
// //                                     items: toDateItem.map((String items) {
// //                                       return DropdownMenuItem(
// //                                         value: items,
// //                                         child: Text(items),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (String? newValue) {
// //                                       setState(() {
// //                                         toDropDownValue = newValue!;
// //                                       });
// //                                     },
// //                                     value: toDropDownValue,
// //                                     icon: Icon(
// //                                       Icons.keyboard_arrow_down,
// //                                       color: AppTheme.themeColor,
// //                                       size: 15,
// //                                     ),
// //                                     isExpanded: true,
// //                                     underline: SizedBox(),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: 30),
// //                       Row(
// //                         children: [
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "Leave Type",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 5),
// //                                 Container(
// //                                   width: double.infinity,
// //                                   height: 45,
// //                                   padding: const EdgeInsets.only(
// //                                     left: 5,
// //                                     right: 5,
// //                                     top: 5,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     shape: BoxShape.rectangle,
// //                                     border: Border.all(
// //                                       color: AppTheme.greyColor,
// //                                       width: 2.0,
// //                                     ),
// //                                   ),
// //                                   child: DropdownButton(
// //                                     items: items.map((String items) {
// //                                       return DropdownMenuItem(
// //                                         value: items,
// //                                         child: Text(items),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (String? newValue) {
// //                                       setState(() {
// //                                         dropdownvalue = newValue!;
// //                                       });
// //                                       checkTheLeaveBalance();
// //                                     },
// //                                     value: dropdownvalue,
// //                                     icon: Icon(
// //                                       Icons.keyboard_arrow_down,
// //                                       color: AppTheme.themeColor,
// //                                       size: 15,
// //                                     ),
// //                                     isExpanded: true,
// //                                     underline: SizedBox(),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           SizedBox(width: 5),
// //                           Expanded(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "Leave Balance",
// //                                   style: TextStyle(
// //                                     fontSize: 14.5,
// //                                     color: AppTheme.themeColor,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 5),
// //                                 Container(
// //                                   width: double.infinity,
// //                                   height: 45,
// //                                   padding: EdgeInsets.all(5),
// //                                   decoration: BoxDecoration(
// //                                     shape: BoxShape.rectangle,
// //                                     border: Border.all(
// //                                       color: AppTheme.greyColor,
// //                                       width: 2.0,
// //                                     ),
// //                                   ),
// //                                   child: Row(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.center,
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       Expanded(
// //                                         child: Text(
// //                                           "${leaveBalanceStr.toString()}",
// //                                           style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontSize: 14.5,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: 20),

// //                       Text(
// //                         "Reason",
// //                         style: TextStyle(
// //                           fontSize: 14.5,
// //                           color: AppTheme.themeColor,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                       SizedBox(height: 5),
// //                       Form(
// //                         key: _formKey,
// //                         child: Container(
// //                           width: double.infinity,
// //                           padding: const EdgeInsets.only(
// //                             left: 5,
// //                             right: 5,
// //                             top: 5,
// //                           ),
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.rectangle,
// //                             border: Border.all(
// //                               color: AppTheme.greyColor,
// //                               width: 2.0,
// //                             ),
// //                           ),
// //                           child: TextField(
// //                             minLines: 1,
// //                             maxLines: 5,
// //                             keyboardType: TextInputType.multiline,
// //                             controller: reasonController,
// //                             maxLength: 500,
// //                             decoration: InputDecoration(
// //                               border: InputBorder.none,
// //                             ),
// //                           ),
// //                         ),
// //                       ),

// //                       SizedBox(height: 10),
// //                       TextButton(
// //                         onPressed: () {
// //                           applyLeave();
// //                         },
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(10),
// //                             color: AppTheme.orangeColor,
// //                           ),
// //                           height: 45,
// //                           padding: const EdgeInsets.all(10),
// //                           child: const Center(
// //                             child: Text(
// //                               "Submit For Approval",
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w900,
// //                                 fontSize: 16,
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }

// //   _showFromDatePicker() async {
// //     var nowDate = DateTime.now();
// //     var lastDate = DateTime(nowDate.year, nowDate.month + 2, 1);
// //     var firstDate = DateTime(nowDate.year, nowDate.month - 1, 1);

// //     DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       firstDate: firstDate,
// //       lastDate: lastDate,
// //     );
// //     if (pickedDate != null) {
// //       fromDate = DateFormat("yyyy-MM-dd").format(pickedDate);
// //       setState(() {
// //         fromDateStr = fromDate;
// //       });
// //     }
// //   }

// //   _showEndDatePicker() async {
// //     var nowDate = DateFormat("yyyy-MM-dd").parse(fromDate);
// //     var lastDate = DateTime(nowDate.year, nowDate.month, nowDate.day + 6);

// //     DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       firstDate: nowDate,
// //       lastDate: lastDate,
// //     );
// //     if (pickedDate != null) {
// //       toDate = DateFormat("yyyy-MM-dd").format(pickedDate);

// //       var fDate = DateFormat("dd MMM yyyy").format(nowDate);
// //       var tDate = DateFormat("dd MMM yyyy").format(pickedDate);

// //       setState(() {
// //         dateRageStr = "$fDate To $tDate";
// //         toDateStr = toDate;
// //       });
// //     }
// //   }

// //   _showEndDateValidation() {
// //     if (fromDate.isEmpty) {
// //       Toast.show(
// //         "Please Select From Date First!!!",
// //         duration: Toast.lengthLong,
// //         gravity: Toast.bottom,
// //         backgroundColor: Colors.red,
// //       );
// //     } else {
// //       _showEndDatePicker();
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     Future.delayed(const Duration(milliseconds: 0), () {
// //       _buildListItems();
// //     });
// //   }

// //   _buildListItems() async {
// //     APIDialog.showAlertDialog(context, "Please Wait...");
// //     setState(() {
// //       isLoading = true;
// //     });
// //     userIdStr = await MyUtils.getSharedPreferences("user_id");
// //     fullNameStr = await MyUtils.getSharedPreferences("full_name");
// //     token = await MyUtils.getSharedPreferences("token");
// //     designationStr = await MyUtils.getSharedPreferences("designation");
// //     empId = await MyUtils.getSharedPreferences("emp_id");
// //     baseUrl = await MyUtils.getSharedPreferences("base_url");
// //     clientCode = await MyUtils.getSharedPreferences("client_code");

// //     if (Platform.isAndroid) {
// //       platform = "Android";
// //     } else if (Platform.isIOS) {
// //       platform = "iOS";
// //     } else {
// //       platform = "Other";
// //     }
// //     Navigator.pop(context);
// //     setState(() {
// //       isLoading = false;
// //     });

// //     getLeaveType();
// //   }

// //   getLeaveType() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     APIDialog.showAlertDialog(context, 'Please Wait...');
// //     try {
// //       String baseUrl = await MyUtils.getSharedPreferences("base_url") ?? "";
// //       String token = await MyUtils.getSharedPreferences("token") ?? "";
// //       String clientCode =
// //           await MyUtils.getSharedPreferences("client_code") ?? "";

// //       ApiBaseHelper helper = ApiBaseHelper();
// //       var response = await helper.getWithToken(
// //         baseUrl,
// //         "get-leave-balance",
// //         token,
// //         clientCode,
// //         context,
// //       );
// //       Navigator.pop(context);
// //       var responseJSON = json.decode(response.body);
// //       print(responseJSON);
// //       if (responseJSON['code'] == 200) {
// //         leaveTypeList.clear();
// //         leaveTypeList = responseJSON['data'];
// //         items.clear();

// //         var firstposi = true;
// //         for (int i = 0; i < leaveTypeList.length; i++) {
// //           String leaveType = leaveTypeList[i]['leave_name'].toString();
// //           String leavekey = leaveTypeList[i]['leave_type'].toString();
// //           if (leavekey != "short_leave") {
// //             items.add(leaveType);
// //             if (firstposi) {
// //               dropdownvalue = leaveType;
// //               selectedLeaveTypeKey = leavekey;
// //               firstposi = false;
// //             }
// //             checkTheLeaveBalance();
// //           }
// //         }
// //         setState(() {
// //           isLoading = false;
// //         });

// //         if (items.isEmpty) {
// //           Toast.show(
// //             "Leave Type Not Found!!!!",
// //             duration: Toast.lengthLong,
// //             gravity: Toast.bottom,
// //             backgroundColor: Colors.red,
// //           );
// //           _finishTheScreen();
// //         } else {
// //           getLeaveBalance();
// //         }
// //       } else {
// //         Toast.show(
// //           responseJSON['message'] ?? "Failed to load leave types",
// //           duration: Toast.lengthLong,
// //           gravity: Toast.bottom,
// //           backgroundColor: Colors.red,
// //         );

// //         setState(() {
// //           isLoading = false;
// //         });

// //         _finishTheScreen();
// //       }
// //     } catch (e) {
// //       Navigator.pop(context);
// //       print("Error fetching leave types: $e");
// //       Toast.show(
// //         "Network error",
// //         duration: Toast.lengthLong,
// //         gravity: Toast.bottom,
// //         backgroundColor: Colors.red,
// //       );
// //       setState(() {
// //         isLoading = false;
// //       });
// //       _finishTheScreen();
// //     }
// //   }

// //   getLeaveBalance() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     APIDialog.showAlertDialog(context, 'Please Wait...');
// //     ApiBaseHelper helper = ApiBaseHelper();
// //     var response = await helper.getWithToken(
// //       baseUrl,
// //       'get-leave-balance',
// //       token,
// //       clientCode!,
// //       context,
// //     );
// //     Navigator.pop(context);
// //     var responseJSON = json.decode(response.body);
// //     print(responseJSON);
// //     if (responseJSON['code'] == 200) {
// //       leaveBalanceList.clear();
// //       leaveBalanceList = responseJSON['data'];

// //       for (int i = 0; i < leaveBalanceList.length; i++) {
// //         String leaveType = leaveBalanceList[i]['leave_type'].toString();
// //         if (selectedLeaveTypeKey == leaveType) {
// //           leaveBalanceStr = 0;
// //           if (leaveBalanceList[i]['leave_balance'] != null) {
// //             leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
// //           }
// //           break;
// //         }
// //       }
// //     }

// //     setState(() {
// //       isLoading = false;
// //     });
// //   }

// //   _finishTheScreen() {
// //     Navigator.of(context).pop();
// //   }

// //   checkTheLeaveBalance() async {
// //     for (int i = 0; i < leaveTypeList.length; i++) {
// //       String leaveType = leaveTypeList[i]['leave_name'].toString();
// //       String leavekey = leaveTypeList[i]['leave_type'].toString();
// //       if (leaveType == dropdownvalue) {
// //         selectedLeaveTypeKey = leavekey;
// //         break;
// //       }
// //     }

// //     print("Selected Leave Type Key : $selectedLeaveTypeKey");

// //     for (int i = 0; i < leaveBalanceList.length; i++) {
// //       String leaveType = leaveBalanceList[i]['leave_type'].toString();
// //       print("Leave Type Key : $leaveType");
// //       if (selectedLeaveTypeKey == leaveType) {
// //         leaveBalanceStr = 0;
// //         if (leaveBalanceList[i]['leave_balance'] != null) {
// //           leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
// //         }
// //         break;
// //       } else {
// //         leaveBalanceStr = 0;
// //       }
// //     }
// //     print("leaveBalanceStr : $leaveBalanceStr");

// //     setState(() {});
// //   }

// //   applyLeave() async {
// //     APIDialog.showAlertDialog(context, 'Please Wait...');
// //     ApiBaseHelper helper = ApiBaseHelper();
// //     final SharedPreferences sp = await SharedPreferences.getInstance();
// //     String? empId = sp.getString("emp_id");
// //     String? token = sp.getString("token");
// //     var detailArray = [];

// //     if (fromDate.isNotEmpty && toDate.isNotEmpty) {
// //       if (fromDate == toDate) {
// //         var requestModel = {
// //           "leave_date": fromDate,
// //           "leave_type": selectedLeaveTypeKey,
// //           "leave_status": fromDropDownValue,
// //         };
// //         detailArray.add(requestModel);
// //       } else {
// //         DateTime fDate = DateFormat("yyyy-MM-dd").parse(fromDate);
// //         DateTime tDate = DateFormat("yyyy-MM-dd").parse(toDate);
// //         int diffrence = tDate.difference(fDate).inDays;

// //         if (diffrence > 1) {
// //           List<DateTime> days = getDaysInBetween(fDate, tDate);

// //           var requestModelfrom = {
// //             "leave_date": fromDate,
// //             "leave_type": selectedLeaveTypeKey,
// //             "leave_status": fromDropDownValue,
// //           };
// //           detailArray.add(requestModelfrom);

// //           days.forEach((day) {
// //             String date = day.toString().split(' ')[0];
// //             String leaveType = selectedLeaveTypeKey;
// //             String leaveStatus = "Full Day";
// //             var requestModeldyn = {
// //               "leave_date": date,
// //               "leave_type": leaveType,
// //               "leave_status": leaveStatus,
// //             };
// //             detailArray.add(requestModeldyn);
// //           });

// //           var requestModelto = {
// //             "leave_date": toDate,
// //             "leave_type": selectedLeaveTypeKey,
// //             "leave_status": toDropDownValue,
// //           };
// //           detailArray.add(requestModelto);
// //         } else if (diffrence == 1) {
// //           var requestModelfrom = {
// //             "leave_date": fromDate,
// //             "leave_type": selectedLeaveTypeKey,
// //             "leave_status": fromDropDownValue,
// //           };
// //           var requestModelto = {
// //             "leave_date": toDate,
// //             "leave_type": selectedLeaveTypeKey,
// //             "leave_status": toDropDownValue,
// //           };
// //           detailArray.add(requestModelfrom);
// //           detailArray.add(requestModelto);
// //         }
// //       }
// //     }

// //     var request = {
// //       "emp_id": empId,
// //       "leave_start_date": fromDate,
// //       "leave_end_date": toDate,
// //       "reason": reasonController.text.toString(),
// //       "leave_details": detailArray,
// //     };

// //     try {
// //       var response = await helper.postAPIWithHeader(
// //         baseUrl,
// //         'apply-leave', // Update the endpoint to 'apply-leave'
// //         request,
// //         context,
// //         token!,
// //       );
// //       Navigator.pop(context);
// //       var responseJSON = response; // Use the response directly
// //       if (responseJSON['code'] == 200) {
// //         Toast.show(
// //           responseJSON['message'],
// //           duration: Toast.lengthLong,
// //           gravity: Toast.bottom,
// //         );
// //         Navigator.pop(context, true);
// //       } else {
// //         Toast.show(
// //           responseJSON['message'],
// //           duration: Toast.lengthLong,
// //           gravity: Toast.bottom,
// //           backgroundColor: Colors.red,
// //         );
// //       }
// //     } catch (e) {
// //       Navigator.pop(context);
// //       print("Error applying for leave: $e");
// //       Toast.show(
// //         "Network error",
// //         duration: Toast.lengthLong,
// //         gravity: Toast.bottom,
// //         backgroundColor: Colors.red,
// //       );
// //     }
// //   }

// //   List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
// //     List<DateTime> days = [];
// //     for (int i = 1; i <= endDate.difference(startDate).inDays - 1; i++) {
// //       days.add(startDate.add(Duration(days: i)));
// //     }
// //     return days;
// //   }
// // }

// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
// import 'dart:io';
// import '../network/Utils.dart';
// import '../network/api_dialog.dart';
// import '../network/api_helper.dart';
// import '../utils/app_theme.dart';

// class ApplyLeaveScreen extends StatefulWidget {
//   const ApplyLeaveScreen({super.key});

//   @override
//   _ApplyLeaveScreen createState() => _ApplyLeaveScreen();
// }

// class _ApplyLeaveScreen extends State<ApplyLeaveScreen> {
//   String dateRageStr = "Please Select Date Range";
//   String fromDateStr = "Select From Date";
//   String toDateStr = "Select To Date";
//   String fromDate = "";
//   String toDate = "";
//   bool isLoading = false;
//   late var userIdStr;
//   late var fullNameStr;
//   late var designationStr;
//   late var token;
//   late var clientCode;
//   late var empId;
//   late var baseUrl;
//   late var platform;
//   List<dynamic> leaveTypeList = [];
//   List<dynamic> leaveBalanceList = [];
//   var items = [''];
//   var fromDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
//   String fromDropDownValue = 'Full Day';
//   String selectedLeaveTypeKey = '';
//   String dropdownvalue = '';
//   double leaveBalanceStr = 0;
//   final _formKey = GlobalKey<FormState>();
//   var reasonController = TextEditingController();
//   var toDateItem = ['Full Day', 'First Half Day', 'Second Half Day'];
//   String toDropDownValue = 'Full Day';
//   List<customDateRage> customeLeaveList = [];
//   List<customLeaveBalanceList> cusBalanceList = [];
//   List<dynamic> employeeOffLisrt = [];
//   String FHStatus = "First Half Day";
//   String SHStatus = "Second Half Day";
//   bool isDocumentRequired = false;
//   bool isImageSelected = false;

//   XFile? imageFile;
//   File? file;

//   String selectedDocumentType = "0";
//   String selectedDocumentPath = "";

//   @override
//   Widget build(BuildContext context) {
//     ToastContext().init(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.keyboard_arrow_left_outlined,
//             color: Colors.black,
//             size: 35,
//           ),
//           onPressed: () => {Navigator.of(context).pop()},
//         ),
//         backgroundColor: AppTheme.at_details_header,
//         title: const Text(
//           "Apply Leave",
//           style: TextStyle(
//             fontSize: 18.5,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         /*actions: [IconButton(onPressed: (){
//           _showAlertDialog();

//         }, icon: SvgPicture.asset("assets/logout.svg"))] ,*/
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center()
//           : ListView(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10),
//                       GridView.count(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         children: List.generate(cusBalanceList.length, (index) {
//                           return Padding(
//                             padding: EdgeInsets.all(5),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppTheme.leaveCard,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10.0),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       cusBalanceList[index].LeaveCount,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       cusBalanceList[index].LeaveName,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                         color: AppTheme.themeColor,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "From Date",
//                                   style: TextStyle(
//                                     fontSize: 14.5,
//                                     color: AppTheme.themeColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 InkWell(
//                                   onTap: () {
//                                     _showFromDatePicker();
//                                   },
//                                   child: Container(
//                                     width: double.infinity,
//                                     height: 45,
//                                     padding: EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       border: Border.all(
//                                         color: AppTheme.greyColor,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             fromDateStr,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14.5,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(width: 5),
//                                         SvgPicture.asset(
//                                           'assets/at_calendar.svg',
//                                           height: 21,
//                                           width: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "To Date",
//                                   style: TextStyle(
//                                     fontSize: 14.5,
//                                     color: AppTheme.themeColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 InkWell(
//                                   onTap: () {
//                                     // _showEndDatePicker();
//                                     _showEndDateValidation();
//                                   },
//                                   child: Container(
//                                     width: double.infinity,
//                                     height: 45,
//                                     padding: EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       border: Border.all(
//                                         color: AppTheme.greyColor,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             toDateStr,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14.5,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(width: 5),
//                                         SvgPicture.asset(
//                                           'assets/at_calendar.svg',
//                                           height: 21,
//                                           width: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 30),

//                       employeeOffLisrt.length == 0
//                           ? SizedBox(height: 5)
//                           : ListView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: employeeOffLisrt.length,
//                               itemBuilder: (BuildContext, indx) {
//                                 String date = employeeOffLisrt[indx]['date']
//                                     .toString();
//                                 String type = employeeOffLisrt[indx]['type']
//                                     .toString();
//                                 String status = employeeOffLisrt[indx]['status']
//                                     .toString();
//                                 bool showStatus = false;
//                                 if (status == 'FH' || status == "SH") {
//                                   showStatus = true;
//                                 }

//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 15),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           color: Colors.white,
//                                           border: Border.all(
//                                             color: AppTheme.orangeColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: 7,
//                                             right: 10,
//                                             top: 5,
//                                             bottom: 10,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(height: 5),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Text(
//                                                       "Date : $date",
//                                                       style: TextStyle(
//                                                         color:
//                                                             AppTheme.themeColor,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: Text(
//                                                       showStatus
//                                                           ? "$type ($status)"
//                                                           : type,
//                                                       style: TextStyle(
//                                                         color: AppTheme
//                                                             .orangeColor,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 30),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),

//                       customeLeaveList.length == 0
//                           ? SizedBox(height: 5)
//                           : ListView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: customeLeaveList.length,
//                               itemBuilder: (BuildContext, indx) {
//                                 String date = customeLeaveList[indx].LeaveDate;
//                                 String leaveType =
//                                     customeLeaveList[indx].LeaveType;
//                                 String leaveStatus =
//                                     customeLeaveList[indx].LeaveStatus;
//                                 String status =
//                                     customeLeaveList[indx].DayStatus;
//                                 bool showText = false;
//                                 if (status == "FH" || status == "SH") {
//                                   showText = true;
//                                 }
//                                 String selectedStatusText = "Full Day";
//                                 if (status == "FH") {
//                                   selectedStatusText = SHStatus;
//                                 }
//                                 if (status == "SH") {
//                                   selectedStatusText = FHStatus;
//                                 }
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 15),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           color: Colors.white,
//                                           border: Border.all(
//                                             color: AppTheme.orangeColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: 7,
//                                             right: 10,
//                                             top: 5,
//                                             bottom: 10,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(height: 5),
//                                               Text(
//                                                 "Date : $date",
//                                                 style: TextStyle(
//                                                   color:
//                                                       AppTheme.task_description,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           "Leave Type",
//                                                           style: TextStyle(
//                                                             fontSize: 14.5,
//                                                             color: AppTheme
//                                                                 .themeColor,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 5),
//                                                         Container(
//                                                           width:
//                                                               double.infinity,
//                                                           height: 55,
//                                                           padding:
//                                                               const EdgeInsets.only(
//                                                                 left: 5,
//                                                                 right: 5,
//                                                                 top: 5,
//                                                               ),
//                                                           decoration: BoxDecoration(
//                                                             shape: BoxShape
//                                                                 .rectangle,
//                                                             border: Border.all(
//                                                               color: AppTheme
//                                                                   .greyColor,
//                                                               width: 2.0,
//                                                             ),
//                                                           ),
//                                                           child: DropdownButton(
//                                                             items: items.map((
//                                                               String items,
//                                                             ) {
//                                                               return DropdownMenuItem(
//                                                                 value: items,
//                                                                 child: Text(
//                                                                   items,
//                                                                 ),
//                                                               );
//                                                             }).toList(),
//                                                             onChanged:
//                                                                 (
//                                                                   String?
//                                                                   newValue,
//                                                                 ) {
//                                                                   setState(
//                                                                     () {},
//                                                                   );
//                                                                   setTheLeaveKey(
//                                                                     indx,
//                                                                     newValue!,
//                                                                   );
//                                                                 },
//                                                             value: leaveType,
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .keyboard_arrow_down,
//                                                               color: AppTheme
//                                                                   .themeColor,
//                                                               size: 15,
//                                                             ),
//                                                             isExpanded: true,
//                                                             underline:
//                                                                 SizedBox(),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           "Leave Status",
//                                                           style: TextStyle(
//                                                             fontSize: 14.5,
//                                                             color: AppTheme
//                                                                 .themeColor,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 5),
//                                                         Container(
//                                                           width:
//                                                               double.infinity,
//                                                           height: 55,
//                                                           padding:
//                                                               const EdgeInsets.only(
//                                                                 left: 5,
//                                                                 right: 5,
//                                                                 top: 5,
//                                                               ),
//                                                           decoration: BoxDecoration(
//                                                             shape: BoxShape
//                                                                 .rectangle,
//                                                             border: Border.all(
//                                                               color: AppTheme
//                                                                   .greyColor,
//                                                               width: 2.0,
//                                                             ),
//                                                           ),
//                                                           child: showText
//                                                               ? Center(
//                                                                   child: Text(
//                                                                     selectedStatusText,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     style: const TextStyle(
//                                                                       fontSize:
//                                                                           14.5,
//                                                                       color: Colors
//                                                                           .black,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : DropdownButton(
//                                                                   items: fromDateItem.map((
//                                                                     String
//                                                                     items,
//                                                                   ) {
//                                                                     return DropdownMenuItem(
//                                                                       value:
//                                                                           items,
//                                                                       child: Text(
//                                                                         items,
//                                                                       ),
//                                                                     );
//                                                                   }).toList(),
//                                                                   onChanged:
//                                                                       (
//                                                                         String?
//                                                                         newValue,
//                                                                       ) {
//                                                                         setState(() {
//                                                                           customeLeaveList[indx].LeaveStatus =
//                                                                               newValue!;
//                                                                           //toDropDownValue = newValue!;
//                                                                         });
//                                                                         _checkOnRunningBalance();
//                                                                       },
//                                                                   value:
//                                                                       leaveStatus,
//                                                                   icon: Icon(
//                                                                     Icons
//                                                                         .keyboard_arrow_down,
//                                                                     color: AppTheme
//                                                                         .themeColor,
//                                                                     size: 15,
//                                                                   ),
//                                                                   isExpanded:
//                                                                       true,
//                                                                   underline:
//                                                                       SizedBox(),
//                                                                 ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 25),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),

//                       isDocumentRequired
//                           ? Padding(
//                               padding: const EdgeInsets.only(top: 15),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white,
//                                   border: Border.all(
//                                     color: AppTheme.orangeColor,
//                                     width: 1.0,
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 7,
//                                     right: 10,
//                                     top: 5,
//                                     bottom: 10,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               "Please Upload Document For Sick Leave",
//                                               style: TextStyle(
//                                                 color: AppTheme.themeColor,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: 5),
//                                           TextButton(
//                                             onPressed: () {
//                                               //  imageSelector();
//                                               _showBottamPicker();
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: AppTheme.orangeColor,
//                                               ),
//                                               height: 45,
//                                               padding: const EdgeInsets.all(10),
//                                               child: const Center(
//                                                 child: Text(
//                                                   "Browse",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w900,
//                                                     fontSize: 16,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10),

//                                       isImageSelected
//                                           ? selectedDocumentType == "1"
//                                                 ? Container(
//                                                     width: double.infinity,
//                                                     height: 300,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey,
//                                                       shape: BoxShape.rectangle,
//                                                       image: DecorationImage(
//                                                         image: FileImage(file!),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : Container(
//                                                     width: double.infinity,
//                                                     height: 300,
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                             10.0,
//                                                           ),
//                                                       child: Image.asset(
//                                                         "assets/document_preview.png",
//                                                         height: 300,
//                                                       ),
//                                                     ),
//                                                   )
//                                           : const SizedBox(height: 1),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : SizedBox(height: 1),

//                       SizedBox(height: 10),
//                       Text(
//                         "Reason",
//                         style: TextStyle(
//                           fontSize: 14.5,
//                           color: AppTheme.themeColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Form(
//                         key: _formKey,
//                         child: Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.only(
//                             left: 5,
//                             right: 5,
//                             top: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             border: Border.all(
//                               color: AppTheme.greyColor,
//                               width: 2.0,
//                             ),
//                           ),
//                           child: TextField(
//                             minLines: 1,
//                             maxLines: 5,
//                             keyboardType: TextInputType.multiline,
//                             controller: reasonController,
//                             maxLength: 500,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 10),
//                       TextButton(
//                         onPressed: () {
//                           checkValidationForDiffer();
//                           //checkValidation();
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: AppTheme.orangeColor,
//                           ),
//                           height: 45,
//                           padding: const EdgeInsets.all(10),
//                           child: const Center(
//                             child: Text(
//                               "Submit For Approval",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   _showFromDatePicker() async {
//     var nowDate = DateTime.now();
//     var lastDate = DateTime(nowDate.year, nowDate.month + 2, 1);
//     var firstDate = DateTime(nowDate.year, nowDate.month - 1, 1);

//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: firstDate,
//       lastDate: lastDate,
//     );
//     if (pickedDate != null) {
//       fromDate = DateFormat("yyyy-MM-dd").format(pickedDate);
//       setState(() {
//         fromDateStr = fromDate;
//       });
//       _showEndDatePicker();
//     }
//   }

//   _showEndDatePicker() async {
//     Toast.show(
//       "Please Select To Date!!",
//       duration: Toast.lengthLong,
//       gravity: Toast.bottom,
//       backgroundColor: Colors.green,
//     );

//     var nowDate = DateFormat("yyyy-MM-dd").parse(fromDate);
//     var lastDate = DateTime(nowDate.year, nowDate.month, nowDate.day + 6);

//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: nowDate,
//       lastDate: lastDate,
//     );
//     if (pickedDate != null) {
//       toDate = DateFormat("yyyy-MM-dd").format(pickedDate);

//       var fDate = DateFormat("dd MMM yyyy").format(nowDate);
//       var tDate = DateFormat("dd MMM yyyy").format(pickedDate);

//       setState(() {
//         dateRageStr = "$fDate To $tDate";
//         toDateStr = toDate;
//       });

//       getEmployeeOffs();
//     }
//   }

//   _showEndDateValidation() {
//     if (fromDate.isEmpty) {
//       Toast.show(
//         "Please Select From Date First!!!",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else {
//       _showEndDatePicker();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 0), () {
//       _buildListItems();
//     });
//   }

//   _buildListItems() async {
//     APIDialog.showAlertDialog(context, "Please Wait...");
//     setState(() {
//       isLoading = true;
//     });
//     userIdStr = await MyUtils.getSharedPreferences("user_id");
//     fullNameStr = await MyUtils.getSharedPreferences("full_name");
//     token = await MyUtils.getSharedPreferences("token");
//     clientCode = await MyUtils.getSharedPreferences("client_code");
//     designationStr = await MyUtils.getSharedPreferences("designation");
//     empId = await MyUtils.getSharedPreferences("emp_id");
//     baseUrl = await MyUtils.getSharedPreferences("base_url");
//     if (Platform.isAndroid) {
//       platform = "Android";
//     } else if (Platform.isIOS) {
//       platform = "iOS";
//     } else {
//       platform = "Other";
//     }
//     Navigator.pop(context);
//     setState(() {
//       isLoading = false;
//     });

//     getLeaveType();
//   }

//   // getLeaveType() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'attendance_management/getAllLeaveType',
//   //     token,
//   //     clientCode,
//   //     context,
//   //   );
//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     leaveTypeList.clear();
//   //     leaveTypeList = responseJSON['data'];
//   //     items.clear();
//   //     cusBalanceList.clear();

//   //     var firstposi = true;
//   //     for (int i = 0; i < leaveTypeList.length; i++) {
//   //       String leaveType = leaveTypeList[i]['leave_type'].toString();
//   //       String leavekey = leaveTypeList[i]['leave_key'].toString();
//   //       print(leavekey);
//   //       if (leavekey != "short_leave") {
//   //         items.add(leaveType);
//   //         cusBalanceList.add(customLeaveBalanceList(leaveType, leavekey, "0"));
//   //         if (firstposi) {
//   //           dropdownvalue = leaveType;
//   //           selectedLeaveTypeKey = leavekey;
//   //           firstposi = false;
//   //         }
//   //       }
//   //     }
//   //     setState(() {
//   //       isLoading = false;
//   //     });

//   //     if (items.isEmpty) {
//   //       Toast.show(
//   //         "Leave Type Not Found!!!!",
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //       _finishTheScreen();
//   //     } else {
//   //       getLeaveBalance();
//   //     }
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );

//   //     setState(() {
//   //       isLoading = false;
//   //     });

//   //     _finishTheScreen();
//   //   }
//   // }

//   getLeaveType() async {
//     setState(() {
//       isLoading = true;
//     });
//     APIDialog.showAlertDialog(context, 'Please Wait...');
//     try {
//       String baseUrl = await MyUtils.getSharedPreferences("base_url") ?? "";
//       String token = await MyUtils.getSharedPreferences("token") ?? "";
//       String clientCode =
//           await MyUtils.getSharedPreferences("client_code") ?? "";

//       ApiBaseHelper helper = ApiBaseHelper();
//       var response = await helper.getWithToken(
//         baseUrl,
//         "get-leave-balance",
//         token,
//         clientCode,
//         context,
//       );

//       Navigator.pop(context);
//       var responseJSON = json.decode(response.body);
//       print(responseJSON);
//       if (responseJSON['error'] == false) {
//         leaveTypeList.clear();
//         leaveTypeList = responseJSON['data'];
//         items.clear();
//         cusBalanceList.clear();

//         var firstposi = true;
//         for (int i = 0; i < leaveTypeList.length; i++) {
//           String leaveType = leaveTypeList[i]['leave_type'].toString();
//           String leavekey = leaveTypeList[i]['leave_name'].toString();
//           print(leavekey);
//           if (leavekey != "short_leave") {
//             items.add(leaveType);
//             cusBalanceList.add(
//               customLeaveBalanceList(leaveType, leavekey, "0"),
//             );
//             if (firstposi) {
//               dropdownvalue = leaveType;
//               selectedLeaveTypeKey = leavekey;
//               firstposi = false;
//             }
//           }
//         }
//         setState(() {
//           isLoading = false;
//         });

//         if (items.isEmpty) {
//           Toast.show(
//             "Leave Type Not Found!!!!",
//             duration: Toast.lengthLong,
//             gravity: Toast.bottom,
//             backgroundColor: Colors.red,
//           );
//           // _finishTheScreen();
//         } else {
//           getLeaveBalance();
//         }
//       } else {
//         Toast.show(
//           responseJSON['message'],
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.red,
//         );

//         setState(() {
//           isLoading = false;
//         });

//         // _finishTheScreen();
//       }
//     } catch (e) {
//       Navigator.pop(context);
//       print("Error fetching leave types: $e");
//       Toast.show(
//         "Network error",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//       setState(() {
//         isLoading = false;
//       });
//       _finishTheScreen();
//     }
//   }

//   // getLeaveBalance() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'attendance_management/getTotalLeaveBalanceForEmp',
//   //     token,
//   //     clientCode,
//   //     context,
//   //   );
//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     leaveBalanceList.clear();
//   //     leaveBalanceList = responseJSON['data'];

//   //     for (int i = 0; i < leaveBalanceList.length; i++) {
//   //       String leaveType = leaveBalanceList[i]['leave_type'].toString();
//   //       if (selectedLeaveTypeKey == leaveType) {
//   //         leaveBalanceStr = 0;
//   //         if (leaveBalanceList[i]['leave_balance'] != null) {
//   //           leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
//   //         }
//   //         break;
//   //       }
//   //     }
//   //     for (int i = 0; i < cusBalanceList.length; i++) {
//   //       String leaveKey = cusBalanceList[i].LeaveKey;
//   //       for (int j = 0; j < leaveBalanceList.length; j++) {
//   //         String leKey = leaveBalanceList[j]['leave_type'].toString();
//   //         if (leaveKey == leKey) {
//   //           if (leaveBalanceList[j]['leave_balance'] != null) {
//   //             cusBalanceList[i].LeaveCount =
//   //                 leaveBalanceList[j]['leave_balance'].toString();
//   //           }
//   //         }
//   //       }
//   //     }
//   //   }

//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }

//   getLeaveBalance() async {
//     setState(() {
//       isLoading = true;
//     });
//     APIDialog.showAlertDialog(context, 'Please Wait...');
//     ApiBaseHelper helper = ApiBaseHelper();
//     var response = await helper.getWithToken(
//       baseUrl,
//       'get-leave-balance',
//       token,
//       clientCode!,
//       context,
//     );

//     Navigator.pop(context);
//     var responseJSON = json.decode(response.body);
//     print(responseJSON);
//     if (responseJSON['error'] == false) {
//       leaveBalanceList.clear();
//       leaveBalanceList = responseJSON['data'];

//       for (int i = 0; i < leaveBalanceList.length; i++) {
//         String leaveType = leaveBalanceList[i]['leave_type'].toString();
//         if (selectedLeaveTypeKey == leaveType) {
//           leaveBalanceStr = 0;
//           if (leaveBalanceList[i]['leave_balance'] != null) {
//             leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
//           }
//           break;
//         }
//       }
//       for (int i = 0; i < cusBalanceList.length; i++) {
//         String leaveKey = cusBalanceList[i].LeaveKey;
//         for (int j = 0; j < leaveBalanceList.length; j++) {
//           String leKey = leaveBalanceList[j]['leave_type'].toString();
//           if (leaveKey == leKey) {
//             if (leaveBalanceList[j]['leave_balance'] != null) {
//               cusBalanceList[i].LeaveCount =
//                   leaveBalanceList[j]['leave_balance'].toString();
//             }
//           }
//         }
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   _finishTheScreen() {
//     Navigator.of(context).pop();
//   }

//   checkTheLeaveBalance() async {
//     for (int i = 0; i < leaveTypeList.length; i++) {
//       String leaveType = leaveTypeList[i]['leave_type'].toString();
//       String leavekey = leaveTypeList[i]['leave_name'].toString();
//       if (leaveType == dropdownvalue) {
//         selectedLeaveTypeKey = leavekey;
//         break;
//       }
//     }

//     print("Selected Leave Type Key : $selectedLeaveTypeKey");

//     for (int i = 0; i < leaveBalanceList.length; i++) {
//       String leaveType = leaveBalanceList[i]['leave_type'].toString();
//       print("Leave Type Key : $leaveType");
//       if (selectedLeaveTypeKey == leaveType) {
//         leaveBalanceStr = 0;
//         if (leaveBalanceList[i]['leave_balance'] != null) {
//           leaveBalanceStr = leaveBalanceList[i]['leave_balance'].toDouble();
//         }
//         break;
//       } else {
//         leaveBalanceStr = 0;
//       }
//     }
//     print("leaveBalanceStr : $leaveBalanceStr");

//     setState(() {});
//   }

//   checkValidation() {
//     if (fromDate.isNotEmpty) {
//       if (toDate.isNotEmpty) {
//         if (reasonController.text.isNotEmpty) {
//           var fDate = DateFormat("yyyy-MM-dd").parse(fromDate);
//           var tDate = DateFormat("yyyy-MM-dd").parse(toDate);
//           var diffrence = (tDate.difference(fDate).inDays) + 1;
//           print(diffrence);

//           double finalDiff = 0.0;
//           if (diffrence > 1) {
//             if (fromDropDownValue == "Second Half Day" ||
//                 fromDropDownValue == "First Half Day") {
//               finalDiff = diffrence - 0.5;
//             } else {
//               finalDiff = diffrence.toDouble();
//             }
//             if (toDropDownValue == "First Half Day" ||
//                 toDropDownValue == "Second Half Day") {
//               finalDiff = finalDiff - 0.5;
//             }
//           } else if (fromDropDownValue == "Full Day" ||
//               (fromDropDownValue == "First Half Day" &&
//                   toDropDownValue == "Second Half Day") ||
//               (fromDropDownValue == "Second Half Day" &&
//                   toDropDownValue == "First Half Day") ||
//               toDropDownValue == "Full Day") {
//             finalDiff = 1.0;
//           } else if (fromDropDownValue == "First Half Day" &&
//               toDropDownValue == "First Half Day") {
//             finalDiff = 0.5;
//           } else if (fromDropDownValue == "Second Half Day" &&
//               toDropDownValue == "Second Half Day") {
//             finalDiff = 0.5;
//           }

//           print(finalDiff);

//           List<dynamic> detailArray = [];

//           String leaveDetailsStr = "";
//           if (diffrence > 2) {
//             List<DateTime> days = getDaysInBetween(fDate, tDate);

//             print("length of days" + days.length.toString());
//             // print the result without time
//             var requestModelfrom = {
//               "leave_date": fromDate,
//               "leave_type": selectedLeaveTypeKey,
//               "leave_status": fromDropDownValue,
//             };

//             detailArray.add(requestModelfrom);
//             //leaveDetailsStr="[{'leave_date':$fromDate,'leave_type':$selectedLeaveTypeKey,'leave_status':$fromDropDownValue},";

//             days.forEach((day) {
//               String date = day.toString().split(' ')[0];
//               String leaveType = selectedLeaveTypeKey;
//               String leaveStatus = "Full Day";
//               var requestModeldyn = {
//                 "leave_date": date,
//                 "leave_type": leaveType,
//                 "leave_status": leaveStatus,
//               };
//               detailArray.add(requestModeldyn);
//               //leaveDetailsStr="$leaveDetailsStr{'leave_date':$date,'leave_type':$leaveType,'leave_status':$leaveStatus},";
//             });

//             var requestModelto = {
//               "leave_date": toDate,
//               "leave_type": selectedLeaveTypeKey,
//               "leave_status": toDropDownValue,
//             };
//             detailArray.add(requestModelto);
//             // leaveDetailsStr="$leaveDetailsStr{'leave_date':$toDate,'leave_type':$selectedLeaveTypeKey,'leave_status':$toDropDownValue}]";
//           } else if (diffrence == 2) {
//             var requestModelfrom = {
//               "leave_date": fromDate,
//               "leave_type": selectedLeaveTypeKey,
//               "leave_status": fromDropDownValue,
//             };
//             var requestModelto = {
//               "leave_date": toDate,
//               "leave_type": selectedLeaveTypeKey,
//               "leave_status": toDropDownValue,
//             };
//             detailArray.add(requestModelfrom);
//             detailArray.add(requestModelto);
//           } else {
//             var requestModelfrom = {
//               "leave_date": fromDate,
//               "leave_type": selectedLeaveTypeKey,
//               "leave_status": fromDropDownValue,
//             };
//             /*var requestModelto = {
//               "leave_date": toDate,
//               "leave_type":selectedLeaveTypeKey,
//               "leave_status":toDropDownValue,
//             };*/

//             detailArray.add(requestModelfrom);
//             //detailArray.add(requestModelto);

//             // leaveDetailsStr="[{'leave_date':$fromDate,'leave_type':$selectedLeaveTypeKey,'leave_status':$fromDropDownValue},";
//             //leaveDetailsStr="$leaveDetailsStr{'leave_date':$toDate,'leave_type':$selectedLeaveTypeKey,'leave_status':$toDropDownValue}]";
//           }

//           if (selectedLeaveTypeKey == 'leave_without_pay' ||
//               selectedLeaveTypeKey == 'short_leave') {
//             _submitLeaveOnServer(detailArray);
//           } else if (finalDiff <= leaveBalanceStr) {
//             _submitLeaveOnServer(detailArray);
//           } else {
//             Toast.show(
//               "You Don't have $finalDiff Leave Balance",
//               duration: Toast.lengthLong,
//               gravity: Toast.bottom,
//               backgroundColor: Colors.red,
//             );
//           }
//         } else {
//           Toast.show(
//             "Please Enter Reason!!!",
//             duration: Toast.lengthLong,
//             gravity: Toast.bottom,
//             backgroundColor: Colors.red,
//           );
//         }
//       } else {
//         Toast.show(
//           "Please Select To Date!!!",
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.red,
//         );
//       }
//     } else {
//       Toast.show(
//         "Please Select From Date!!!",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   _checkOnRunningBalance() {
//     List<LeaveBalanceForValidation> tempBalanceList = [];
//     for (int i = 0; i < customeLeaveList.length; i++) {
//       String leaveName = customeLeaveList[i].LeaveType;
//       String leaveKey = customeLeaveList[i].LeaveKey;
//       String leaveStatus = customeLeaveList[i].LeaveStatus;
//       String date = customeLeaveList[i].LeaveDate;

//       print("Leave Key : $leaveKey");

//       double leaveCount = 0.0;
//       if (leaveStatus == "Second Half Day" || leaveStatus == "First Half Day") {
//         leaveCount = 0.5;
//       } else if (leaveStatus == "Full Day") {
//         leaveCount = 1.0;
//       }
//       bool isAdded = false;
//       int position = 0;
//       for (int j = 0; j < tempBalanceList.length; j++) {
//         String lKey = tempBalanceList[j].LeaveKey;
//         print("lKey Key : $lKey");
//         if (lKey == leaveKey) {
//           isAdded = true;
//           position = j;
//           break;
//         }
//       }

//       if (isAdded) {
//         double alCount = tempBalanceList[position].LeaveBalance;
//         double nCount = alCount + leaveCount;
//         tempBalanceList[position].LeaveBalance = nCount;
//       } else {
//         tempBalanceList.add(
//           LeaveBalanceForValidation(leaveName, leaveKey, leaveCount),
//         );
//       }
//     }
//     for (int i = 0; i < tempBalanceList.length; i++) {
//       double leaveApplied = tempBalanceList[i].LeaveBalance;
//       double accutalCount = 0.0;
//       String lke = tempBalanceList[i].LeaveKey;
//       String lN = tempBalanceList[i].LeaveName;

//       for (int j = 0; j < leaveBalanceList.length; j++) {
//         String leKey = leaveBalanceList[j]['leave_type'].toString();
//         if (lke == leKey) {
//           if (leaveBalanceList[j]['leave_balance'] != null) {
//             accutalCount = leaveBalanceList[j]['leave_balance'].toDouble();
//           }
//           break;
//         }
//       }
//       print(
//         "Leave Name:${tempBalanceList[i].LeaveName}, Leave Key:${tempBalanceList[i].LeaveKey}, Leave Balance:${tempBalanceList[i].LeaveBalance}",
//       );

//       if (lke == 'sick_leave') {
//         if (leaveApplied > 2) {
//           isDocumentRequired = true;
//           break;
//         } else {
//           isDocumentRequired = false;
//           break;
//         }
//       }
//     }

//     setState(() {});
//   }

//   List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
//     List<DateTime> days = [];
//     for (int i = 1; i <= endDate.difference(startDate).inDays - 1; i++) {
//       days.add(startDate.add(Duration(days: i)));
//     }
//     return days;
//   }

//   _submitLeaveOnServer(List<dynamic> leaveDetails) async {
//     APIDialog.showAlertDialog(context, 'Please Wait...');

//     var requestModel = {
//       "emp_id": empId,
//       "reason": reasonController.text.toString(),
//       "leaveDetails": jsonEncode(leaveDetails),
//     };
//     ApiBaseHelper helper = ApiBaseHelper();
//     var response = await helper.postAPIWithHeader(
//       baseUrl,
//       'apply-leave', // This is the corrected endpoint
//       requestModel,
//       context,
//       token,
//     );
//     Navigator.pop(context);
//     var responseJSON = json.decode(response.body);
//     print(responseJSON);
//     if (responseJSON['error'] == false) {
//       Toast.show(
//         responseJSON['message'],
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//       );
//       // _finishTheScreen();
//     } else {
//       Toast.show(
//         responseJSON['message'],
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   _showCustomDialog(String msg) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ), //this right here
//           child: Container(
//             height: 300,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         _finishTheScreen();
//                       },
//                       child: Icon(
//                         Icons.close_rounded,
//                         color: Colors.red,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     height: 100,
//                     width: double.infinity,
//                     child: Lottie.asset("assets/api_done_anim.json"),
//                   ),
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       msg,
//                       style: TextStyle(
//                         color: AppTheme.orangeColor,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       _finishTheScreen();
//                       //call attendance punch in or out
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: AppTheme.themeColor,
//                       ),
//                       height: 45,
//                       padding: const EdgeInsets.all(10),
//                       child: const Center(
//                         child: Text(
//                           "Done",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   _selectCustomLeaveList(DateTime startDate, DateTime endDate) {
//     List<DateTime> days = [];
//     for (int i = 1; i <= endDate.difference(startDate).inDays - 1; i++) {
//       days.add(startDate.add(Duration(days: i)));
//     }

//     customeLeaveList.clear();
//     if (fromDate == toDate) {
//       bool fDateOff = false;
//       String statuss = "FULL";
//       for (int i = 0; i < employeeOffLisrt.length; i++) {
//         String date = employeeOffLisrt[i]['date'].toString();
//         String status = employeeOffLisrt[i]['status'].toString();
//         if (fromDate == date) {
//           if (status != 'FH' && status != "SH") {
//             fDateOff = true;
//             statuss = status;
//             break;
//           } else {
//             fDateOff = false;
//             statuss = status;
//             break;
//           }
//         }
//       }
//       if (!fDateOff) {
//         String selectedLeaveStatus = fromDropDownValue;
//         if (statuss == "FH") {
//           selectedLeaveStatus = SHStatus;
//         }
//         if (statuss == "SH") {
//           selectedLeaveStatus = FHStatus;
//         }
//         customeLeaveList.add(
//           customDateRage(
//             fromDate,
//             dropdownvalue,
//             selectedLeaveTypeKey,
//             "",
//             selectedLeaveStatus,
//             statuss,
//           ),
//         );
//       }
//     } else {
//       bool fDateOff = false;
//       String statuss = "FULL";
//       for (int i = 0; i < employeeOffLisrt.length; i++) {
//         String date = employeeOffLisrt[i]['date'].toString();
//         String status = employeeOffLisrt[i]['status'].toString();
//         if (fromDate == date) {
//           if (status != 'FH' && status != "SH") {
//             fDateOff = true;
//             statuss = status;
//             break;
//           } else {
//             fDateOff = false;
//             statuss = status;
//             break;
//           }
//         }
//       }
//       if (!fDateOff) {
//         String selectedLeaveStatus = fromDropDownValue;
//         if (statuss == "FH") {
//           selectedLeaveStatus = SHStatus;
//         }
//         if (statuss == "SH") {
//           selectedLeaveStatus = FHStatus;
//         }
//         customeLeaveList.add(
//           customDateRage(
//             fromDate,
//             dropdownvalue,
//             selectedLeaveTypeKey,
//             "",
//             selectedLeaveStatus,
//             statuss,
//           ),
//         );
//       }
//       days.forEach((day) {
//         String date = day.toString().split(' ')[0];
//         bool isOff = false;
//         String statuss = "FULL";
//         for (int i = 0; i < employeeOffLisrt.length; i++) {
//           String ds = employeeOffLisrt[i]['date'].toString();
//           String status = employeeOffLisrt[i]['status'].toString();
//           if (date == ds) {
//             if (status != 'FH' && status != "SH") {
//               isOff = true;
//               statuss = status;
//               break;
//             } else {
//               isOff = false;
//               statuss = status;
//               break;
//             }

//             // isOff=true;
//             // break;
//           }
//         }
//         if (!isOff) {
//           String selectedLeaveStatus = fromDropDownValue;
//           if (statuss == "FH") {
//             selectedLeaveStatus = SHStatus;
//           }
//           if (statuss == "SH") {
//             selectedLeaveStatus = FHStatus;
//           }
//           customeLeaveList.add(
//             customDateRage(
//               date,
//               dropdownvalue,
//               selectedLeaveTypeKey,
//               "",
//               selectedLeaveStatus,
//               statuss,
//             ),
//           );
//         }
//       });

//       bool tDateOff = false;
//       String statuss1 = "FULL";
//       for (int i = 0; i < employeeOffLisrt.length; i++) {
//         String date = employeeOffLisrt[i]['date'].toString();
//         String status = employeeOffLisrt[i]['status'].toString();
//         if (toDate == date) {
//           if (status != 'FH' && status != "SH") {
//             tDateOff = true;
//             statuss1 = status;
//             break;
//           } else {
//             tDateOff = false;
//             statuss1 = status;
//             break;
//           }
//           /*tDateOff=true;
//           break;*/
//         }
//       }
//       if (!tDateOff) {
//         String selectedLeaveStatus = fromDropDownValue;
//         if (statuss1 == "FH") {
//           selectedLeaveStatus = SHStatus;
//         }
//         if (statuss1 == "SH") {
//           selectedLeaveStatus = FHStatus;
//         }
//         customeLeaveList.add(
//           customDateRage(
//             toDate,
//             dropdownvalue,
//             selectedLeaveTypeKey,
//             "",
//             selectedLeaveStatus,
//             statuss1,
//           ),
//         );
//       }
//     }
//     print("length of the List${customeLeaveList.length}");

//     if (customeLeaveList.isEmpty) {
//       Toast.show(
//         "Please Select Valid Date!!! Except Public Holiday or Week Off",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }

//     setState(() {});
//   }

//   getEmployeeOffs() async {
//     APIDialog.showAlertDialog(context, 'Please Wait...');
//     ApiBaseHelper helper = ApiBaseHelper();
//     var response = await helper.getWithToken(
//       baseUrl,
//       'attendance_management/getEmployeeOffs?from=$fromDate&to=$toDate',
//       token,
//       clientCode,
//       context,
//     );
//     Navigator.pop(context);
//     var responseJSON = json.decode(response.body);
//     print(responseJSON);
//     if (responseJSON['error'] == false) {
//       employeeOffLisrt.clear();
//       employeeOffLisrt = responseJSON['data'];

//       var fDate1 = DateFormat("yyyy-MM-dd").parse(fromDate);
//       var tDate1 = DateFormat("yyyy-MM-dd").parse(toDate);
//       _selectCustomLeaveList(fDate1, tDate1);
//     } else {
//       var fDate1 = DateFormat("yyyy-MM-dd").parse(fromDate);
//       var tDate1 = DateFormat("yyyy-MM-dd").parse(toDate);
//       _selectCustomLeaveList(fDate1, tDate1);
//     }
//   }

//   checkValidationForDiffer() {
//     List<LeaveBalanceForValidation> tempBalanceList = [];
//     for (int i = 0; i < customeLeaveList.length; i++) {
//       String leaveName = customeLeaveList[i].LeaveType;
//       String leaveKey = customeLeaveList[i].LeaveKey;
//       String leaveStatus = customeLeaveList[i].LeaveStatus;
//       String date = customeLeaveList[i].LeaveDate;

//       print("Leave Key : $leaveKey");

//       double leaveCount = 0.0;
//       if (leaveStatus == "Second Half Day" || leaveStatus == "First Half Day") {
//         leaveCount = 0.5;
//       } else if (leaveStatus == "Full Day") {
//         leaveCount = 1.0;
//       }
//       bool isAdded = false;
//       int position = 0;
//       for (int j = 0; j < tempBalanceList.length; j++) {
//         String lKey = tempBalanceList[j].LeaveKey;
//         print("lKey Key : $lKey");
//         if (lKey == leaveKey) {
//           isAdded = true;
//           position = j;
//           break;
//         }
//       }

//       if (isAdded) {
//         double alCount = tempBalanceList[position].LeaveBalance;
//         double nCount = alCount + leaveCount;
//         tempBalanceList[position].LeaveBalance = nCount;
//       } else {
//         tempBalanceList.add(
//           LeaveBalanceForValidation(leaveName, leaveKey, leaveCount),
//         );
//       }
//     }

//     bool isValidapplication = true;

//     for (int i = 0; i < tempBalanceList.length; i++) {
//       double leaveApplied = tempBalanceList[i].LeaveBalance;
//       double accutalCount = 0.0;
//       String lke = tempBalanceList[i].LeaveKey;
//       String lN = tempBalanceList[i].LeaveName;

//       for (int j = 0; j < leaveBalanceList.length; j++) {
//         String leKey = leaveBalanceList[j]['leave_type'].toString();
//         if (lke == leKey) {
//           if (leaveBalanceList[j]['leave_balance'] != null) {
//             accutalCount = leaveBalanceList[j]['leave_balance'].toDouble();
//           }
//           break;
//         }
//       }
//       print(
//         "Leave Name:${tempBalanceList[i].LeaveName}, Leave Key:${tempBalanceList[i].LeaveKey}, Leave Balance:${tempBalanceList[i].LeaveBalance}",
//       );

//       if (lke != 'leave_without_pay') {
//         if (leaveApplied > accutalCount) {
//           isValidapplication = false;
//           _showInsufficientBalance(leaveApplied, accutalCount, lN);
//           break;
//         }
//       }
//     }
//     if (fromDate.isEmpty) {
//       Toast.show(
//         "Please Select From Date!!!",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else if (toDate.isEmpty) {
//       Toast.show(
//         "Please Select To Date!!!",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else if (customeLeaveList.isEmpty) {
//       Toast.show(
//         "Please Select Valid Date!!!",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else if (!isValidapplication) {
//       Toast.show(
//         "Please Select Valid Leave Type As per Available Balance",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else if (reasonController.text.isEmpty) {
//       Toast.show(
//         "Please Enter Valid Reason For Leave",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     } else {
//       List<dynamic> detailArray = [];
//       for (int i = 0; i < customeLeaveList.length; i++) {
//         String leaveName = customeLeaveList[i].LeaveType;
//         String leaveKey = customeLeaveList[i].LeaveKey;
//         String leaveStatus = customeLeaveList[i].LeaveStatus;
//         String date = customeLeaveList[i].LeaveDate;
//         var requestModelfrom = {
//           "leave_date": date,
//           "leave_type": leaveKey,
//           "leave_status": leaveStatus,
//         };

//         detailArray.add(requestModelfrom);
//       }
//       if (isDocumentRequired) {
//         if (isImageSelected) {
//           if (selectedDocumentType == "1") {
//             submitLeaveWithImage(detailArray);
//           } else {
//             submitLeaveWithDocument(detailArray);
//           }
//         } else {
//           Toast.show(
//             "Please upload Document for Sick Leave",
//             duration: Toast.lengthLong,
//             gravity: Toast.bottom,
//             backgroundColor: Colors.red,
//           );
//         }
//       } else {
//         _submitLeaveOnServer(detailArray);
//       }
//     }
//   }

//   setTheLeaveKey(int position, String LeaveName) {
//     String leaveKey = "";
//     for (int i = 0; i < leaveTypeList.length; i++) {
//       String leaveType = leaveTypeList[i]['leave_type'].toString();
//       String lKey = leaveTypeList[i]['leave_name'].toString();
//       if (leaveType == LeaveName) {
//         leaveKey = lKey;
//         break;
//       }
//     }

//     setState(() {
//       customeLeaveList[position].LeaveType = LeaveName;
//       customeLeaveList[position].LeaveKey = leaveKey;
//     });
//     _checkOnRunningBalance();
//   }

//   _showInsufficientBalance(double applied, double available, String lName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ), //this right here
//           child: Container(
//             height: 300,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Icon(
//                         Icons.close_rounded,
//                         color: Colors.red,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Insufficient Leave Balance!!!",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w900,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   Text(
//                     "You have applied $lName for $applied days but in your account only $available days $lName balance available.",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w900,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       //call attendance punch in or out
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: AppTheme.themeColor,
//                       ),
//                       height: 45,
//                       padding: const EdgeInsets.all(10),
//                       child: const Center(
//                         child: Text(
//                           "OK",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   imageSelector() async {
//     imageFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 60,
//       preferredCameraDevice: CameraDevice.front,
//     );

//     if (imageFile != null) {
//       file = File(imageFile!.path);

//       final imageFiles = imageFile;
//       if (imageFiles != null) {
//         print("You selected  image : " + imageFiles.path.toString());

//         selectedDocumentType = "1";
//         isImageSelected = true;
//         setState(() {
//           debugPrint("SELECTED IMAGE PICK   $imageFiles");
//         });
//       } else {
//         print("You have not taken image");
//       }
//     } else {
//       Toast.show(
//         "Unable to Browse Image. Please try Again...",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   documentSelector() async {
//     print("Document Picker called");
//     List<String> allowedExtentions = [];
//     allowedExtentions.add('pdf');
//     allowedExtentions.add('xlsx');
//     allowedExtentions.add('xls');
//     allowedExtentions.add('pptx');
//     allowedExtentions.add('ppt');
//     allowedExtentions.add('docx');
//     allowedExtentions.add('doc');
//     FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
//       allowedFileExtensions: allowedExtentions,
//     );
//     final path = await FlutterDocumentPicker.openDocument(params: params);
//     print("picked Path : $path");
//     if (path != null) {
//       file = File(path);
//       if (file != null) {
//         print("You selected  image : $path");
//         isImageSelected = true;
//         selectedDocumentType = "2";
//         selectedDocumentPath = path;
//         setState(() {
//           debugPrint("SELECTED IMAGE PICK   $file");
//         });
//       }
//     } else {
//       Toast.show(
//         "Unable to Browse Document. Please try Again...",
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   _showBottamPicker() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext contx) {
//         return StatefulBuilder(
//           builder: (ctx, setDialogState) {
//             return Padding(
//               padding: MediaQuery.of(context).viewInsets,
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Container(
//                           height: 5,
//                           width: 30,
//                           color: AppTheme.greyColor,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 "Browse",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w900,
//                                   color: Colors.black,
//                                   fontSize: 18.5,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Icon(
//                                 Icons.close_rounded,
//                                 color: AppTheme.greyColor,
//                                 size: 32,
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                                 imageSelector();
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     "assets/browse_images.png",
//                                     width: 60,
//                                     height: 60,
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "Images",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16,
//                                       color: AppTheme.themeColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                                 documentSelector();
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     "assets/browse_documents.png",
//                                     width: 60,
//                                     height: 60,
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "Document",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16,
//                                       color: AppTheme.themeColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   submitLeaveWithImage(List<dynamic> leaveDetails) async {
//     APIDialog.showAlertDialog(context, 'Please wait...');
//     String fileName = imageFile!.path.split('/').last;
//     String extension = fileName.split('.').last;

//     FormData formData = FormData.fromMap({
//       "emp_id": empId,
//       "reason": reasonController.text.toString(),
//       "leaveDetails": jsonEncode(leaveDetails),
//       "file": await MultipartFile.fromFile(imageFile!.path, filename: fileName),
//     });
//     String apiUrl = baseUrl + "attendance_management/applyLeaveApplication";
//     print(apiUrl);
//     Dio dio = Dio();
//     dio.options.headers['Content-Type'] = 'multipart/form-data';
//     dio.options.headers['X-Auth-Token'] = token;
//     try {
//       var response = await dio.post(apiUrl, data: formData);
//       print(response.data);
//       Navigator.pop(context);
//       // var responseJSON = json.decode(response.data);
//       //
//       // print(responseJSON);
//       if (response.data['error'] == false) {
//         Toast.show(
//           response.data['message'],
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.green,
//         );
//         _showCustomDialog(response.data['message']);
//       } else {
//         Toast.show(
//           response.data['message'],
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.red,
//         );
//       }
//     } on DioError catch (e) {
//       print(e);
//       print(e.response.toString());
//       Navigator.pop(context);
//       Toast.show(
//         e.message!,
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   submitLeaveWithDocument(List<dynamic> leaveDetails) async {
//     APIDialog.showAlertDialog(context, 'Please wait...');
//     String fileName = selectedDocumentPath.split('/').last;
//     String extension = fileName.split('.').last;

//     FormData formData = FormData.fromMap({
//       "emp_id": empId,
//       "reason": reasonController.text.toString(),
//       "leaveDetails": jsonEncode(leaveDetails),
//       "file": await MultipartFile.fromFile(
//         selectedDocumentPath,
//         filename: fileName,
//       ),
//     });
//     String apiUrl = baseUrl + "attendance_management/applyLeaveApplication";
//     print(apiUrl);
//     Dio dio = Dio();
//     dio.options.headers['Content-Type'] = 'multipart/form-data';
//     dio.options.headers['X-Auth-Token'] = token;
//     try {
//       var response = await dio.post(apiUrl, data: formData);
//       print(response.data);
//       Navigator.pop(context);
//       // var responseJSON = json.decode(response.data);
//       //
//       // print(responseJSON);
//       if (response.data['error'] == false) {
//         Toast.show(
//           response.data['message'],
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.green,
//         );
//         _showCustomDialog(response.data['message']);
//       } else {
//         Toast.show(
//           response.data['message'],
//           duration: Toast.lengthLong,
//           gravity: Toast.bottom,
//           backgroundColor: Colors.red,
//         );
//       }
//     } on DioError catch (e) {
//       print(e);
//       print(e.response.toString());
//       Navigator.pop(context);
//       Toast.show(
//         e.message!,
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//         backgroundColor: Colors.red,
//       );
//     }
//   }
// }

// class customDateRage {
//   String LeaveDate, LeaveType, LeaveKey, LeaveBalance, LeaveStatus, DayStatus;

//   customDateRage(
//     this.LeaveDate,
//     this.LeaveType,
//     this.LeaveKey,
//     this.LeaveBalance,
//     this.LeaveStatus,
//     this.DayStatus,
//   );
// }

// class customLeaveBalanceList {
//   String LeaveName, LeaveKey, LeaveCount;

//   customLeaveBalanceList(this.LeaveName, this.LeaveKey, this.LeaveCount);
// }

// class LeaveBalanceForValidation {
//   String LeaveName, LeaveKey;
//   double LeaveBalance;

//   LeaveBalanceForValidation(this.LeaveName, this.LeaveKey, this.LeaveBalance);
// }
