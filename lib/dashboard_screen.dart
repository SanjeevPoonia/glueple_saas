// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:glueplenew/network/loader.dart';
// import 'package:marquee/marquee.dart';
// import 'package:toast/toast.dart';
// import '../utils/app_theme.dart';
// import 'package:intl/intl.dart';

// class DashboardScreen extends StatefulWidget {
//   dashboardState createState() => dashboardState();
// }

// class dashboardState extends State<DashboardScreen>
//     with WidgetsBindingObserver {
//   var userIdStr = "";
//   var designationStr = "";
//   var token = "";
//   var fullNameStr = "";
//   var empId = "";
//   var baseUrl = "";
//   var clientCode = "";
//   var platform = "";
//   var isAttendanceAccess = "1";
//   bool isLoading = false;
//   bool attStatus = false;
//   bool siteStatus = false;
//   bool lastAttendance = false;
//   bool taskLoading = false;
//   bool leaveLoading = false;
//   bool communityLoading = false;
//   bool showCheckIn = true;
//   bool showStartVisit = true;
//   bool showSiteCheckIn = true;

//   String logedInTime = "00:00:00";
//   //String? _currentAddress;
//   String lastImage = "";
//   bool isUrl = false;
//   List<dynamic> locationList = [];
//   Timer? countdownTimer;
//   Duration? myDuration;
//   /*********Today task************/
//   List<dynamic> taskList = [];
//   List<dynamic> totakTaskList = [];
//   List RandomImages = [
//     'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
//     'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
//     'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
//     'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
//   ];
//   /*********Leave List*****************/
//   List<dynamic> leaveList = [];
//   List<dynamic> totalLeaveList = [];
//   /******Announcement List***************/
//   List<dynamic> announcementList = [];
//   /****************Camera Functionality*****************/
//   double cameraZoom = 1.0;

//   bool noData = false;
//   /**********Upload File IN Background*****************/
//   bool isImageUploading = false;
//   /****************User Notification*********************/
//   bool isNotiLoading = false;
//   String notiStr = "";
//   /************Custom range for Location *****************/
//   int locationRadius = 101;
//   int announcementSize = 0;
//   int taskSize = 0;
//   int leaveSize = 0;
//   int openTaskCount = 0;
//   int closeTaskCount = 0;
//   int watcherCount = 0;
//   /*********************Site Visit Functionality***********/
//   //String? _currentAddressSite;
//   // XFile? capturedImageSite;
//   // File? capturedFileSite;
//   // XFile? imageFileSite;
//   File? fileSite;
//   String subType = "";
//   bool shStartSite = false;
//   bool shSiteCheckIn = false;
//   bool shSiteCheckOut = false;
//   bool shEndSite = false;
//   var cameraSiteName = TextEditingController();
//   var iOSSiteName = TextEditingController();
//   final _focusNode = FocusNode();

//   /*******************************Firebase Messaging*******************/
//   // late AndroidNotificationChannel channel;
//   // //flutterLocalNotificationsPlugin
//   // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//   // bool isFlutterLocalNotificationsInitialized = false;

//   @override
//   Widget build(BuildContext context) {
//     ToastContext().init(context);
//     return ListView(
//       children: [
//         isNotiLoading
//             ? Center(child: Loader())
//             : notiStr == ''
//             ? SizedBox(height: 2)
//             : Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/announc_back_img.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 7, right: 10),
//                   child: Marquee(
//                     text: notiStr,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                     scrollAxis: Axis.horizontal,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     blankSpace: 20,
//                     velocity: 100,
//                     pauseAfterRound: Duration(seconds: 1),
//                     startPadding: 10,
//                     accelerationDuration: Duration(seconds: 1),
//                     accelerationCurve: Curves.linear,
//                     decelerationDuration: Duration(milliseconds: 500),
//                     decelerationCurve: Curves.easeOut,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(10),
//                 height: 40,
//               ),
//         const SizedBox(height: 15),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             width: double.infinity,

//             decoration: const BoxDecoration(color: AppTheme.dashboardheader),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,

//                   children: [
//                     isImageUploading
//                         ? Center(child: Loader())
//                         : lastImage == ""
//                         ? CircleAvatar(
//                             backgroundImage: AssetImage("assets/profile.png"),
//                             radius: 35,
//                           )
//                         : isUrl
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(33.0),
//                             child: CachedNetworkImage(
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.cover,
//                               imageUrl: lastImage,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       CircularProgressIndicator(
//                                         value: downloadProgress.progress,
//                                       ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),
//                             //child: Image.network(empProfile,width: 60,height: 60,fit: BoxFit.cover,),
//                           )
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(33.0),
//                             child: imageFromBase64String(lastImage),
//                           ),

//                     SizedBox(width: 7),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             fullNameStr,
//                             style: TextStyle(
//                               fontSize: 17.5,
//                               fontWeight: FontWeight.w500,
//                               color: AppTheme.orangeColor,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             empId,
//                             style: TextStyle(
//                               fontSize: 14.5,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 7),

//                     attStatus
//                         ? Loader()
//                         : Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "$logedInTime Hrs",
//                                 style: TextStyle(
//                                   fontSize: 17.5,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               isAttendanceAccess == "1"
//                                   ? InkWell(
//                                       onTap: () {
//                                         // _checkValidationForSiteCheck();
//                                         // _checkDeveloperOptionForCheck();
//                                       },
//                                       child: Container(
//                                         width: 100,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           color: AppTheme.orangeColor,
//                                         ),
//                                         height: 30,
//                                         child: Center(
//                                           child: Text(
//                                             showCheckIn == true
//                                                 ? "Check In"
//                                                 : "Check Out",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : SizedBox(height: 1),
//                             ],
//                           ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 isAttendanceAccess == "1"
//                     ? siteStatus
//                           ? Loader()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 shStartSite
//                                     ? InkWell(
//                                         onTap: () {
//                                           // subType = 'start';
//                                           // _checkDeveloperOption();
//                                           //_getCurrentPositionForSite();
//                                         },
//                                         child: Container(
//                                           width: 130,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             color: AppTheme.themeColor,
//                                           ),
//                                           height: 30,
//                                           child: Center(
//                                             child: Text(
//                                               "Start Visit",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),

//                                 SizedBox(width: 1),

//                                 shSiteCheckIn
//                                     ? InkWell(
//                                         onTap: () {
//                                           // subType = 'in';
//                                           // _checkDeveloperOption();
//                                           // _getCurrentPositionForSite();
//                                         },
//                                         child: Container(
//                                           width: 130,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             color: AppTheme.orangeColor,
//                                           ),
//                                           height: 30,
//                                           child: Center(
//                                             child: Text(
//                                               "Site Check In",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),

//                                 SizedBox(width: 1),

//                                 shSiteCheckOut
//                                     ? InkWell(
//                                         onTap: () {
//                                           // subType = 'out';
//                                           // _checkDeveloperOption();
//                                           // _getCurrentPositionForSite();
//                                         },
//                                         child: Container(
//                                           width: 130,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             color: AppTheme.orangeColor,
//                                           ),
//                                           height: 30,
//                                           child: Center(
//                                             child: Text(
//                                               "Site Check Out",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),

//                                 SizedBox(width: 5),

//                                 shEndSite
//                                     ? InkWell(
//                                         onTap: () {
//                                           // subType = 'end';
//                                           // _checkDeveloperOption();
//                                           //_getCurrentPositionForSite();
//                                         },
//                                         child: Container(
//                                           width: 130,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             color: AppTheme.themeColor,
//                                           ),
//                                           height: 30,
//                                           child: Center(
//                                             child: Text(
//                                               "End Visit",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),

//                                 SizedBox(width: 1),
//                               ],
//                             )
//                     : Container(),

//                 /*isAttendanceAccess=="1"?
//                   showCheckIn==false?
//                     siteStatus?
//                       Loader():
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             showStartVisit==false?
//                             InkWell(
//                               onTap: (){
//                                 subType=showSiteCheckIn==true?'in':'out';
//                                 _getCurrentPositionForSite();
//                               },
//                               child: Container(
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: AppTheme.themeColor) ,
//                                 height: 30,
//                                 child:   Center(
//                                   child: Text(showSiteCheckIn==true?"Site Check In":"Site Check Out",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                         fontSize: 16
//                                     ),),
//                                 ),
//                               ),
//                             ):
//                             SizedBox(width: 1,),
//                             SizedBox(width: 10,),
//                             InkWell(
//                               onTap: (){
//                                 subType=showStartVisit==true?'start':'end';
//                                 _getCurrentPositionForSite();
//                               },
//                               child: Container(
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: AppTheme.themeColor) ,
//                                 height: 30,
//                                 child:   Center(
//                                   child: Text(showStartVisit==true?"Start Visit":"End Visit",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                         fontSize: 16
//                                     ),),
//                                 ),
//                               ),
//                             )

//                           ],
//                         ):
//                           SizedBox(height: 1,) :
//                             SizedBox(height: 1,)*/
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 15),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: BoxDecoration(color: AppTheme.filterColor),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "Last 7 Days Report",
//                         style: TextStyle(
//                           color: AppTheme.themeColor,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 17.5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     InkWell(
//                       onTap: () => {
//                         // clientCode == 'MH100'
//                         //     ? Navigator.push(
//                         //         context,
//                         //         MaterialPageRoute(
//                         //           builder: (context) =>
//                         //               MH_AttendanceDetailsScreen(),
//                         //         ),
//                         //       ).then((value) => _getDashboardData())
//                         //     : Navigator.push(
//                         //         context,
//                         //         MaterialPageRoute(
//                         //           builder: (context) =>
//                         //               AttendanceDetailsScreen(),
//                         //         ),
//                         //       ).then((value) => _getDashboardData()),
//                       },
//                       child: Text(
//                         "View All",
//                         style: TextStyle(
//                           color: AppTheme.orangeColor,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.5,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(color: AppTheme.at_green),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Full Day",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(color: AppTheme.at_blue),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Half Day",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(
//                               color: AppTheme.at_yellow,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Leave",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(
//                               color: AppTheme.at_lightgray,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Public Holiday",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(color: AppTheme.at_gray),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Week Off",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(
//                               color: AppTheme.at_purple,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Comp Off",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(color: AppTheme.at_red),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Absent",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(color: AppTheme.at_black),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             "Tour",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Expanded(child: Container()),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 200,
//                   decoration: BoxDecoration(color: AppTheme.filterColor),
//                   child: lastAttendance
//                       ? Center(child: Loader())
//                       : AttendanceChart(data: attendanceDate),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         /*********************Announcements******************/
//         SizedBox(height: 15),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: const BoxDecoration(color: AppTheme.filterColor),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "Community",
//                       style: TextStyle(
//                         color: AppTheme.themeColor,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 17.5,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   announcementSize > 3
//                       ? InkWell(
//                           onTap: () => {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => AnnouncementScreen(),
//                             //   ),
//                             // ).then((value) => _getDashboardData()),
//                           },
//                           child: Text(
//                             "View All",
//                             style: TextStyle(
//                               color: AppTheme.orangeColor,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14.5,
//                             ),
//                           ),
//                         )
//                       : SizedBox(width: 2),
//                 ],
//               ),
//               SizedBox(height: 10),
//               communityLoading
//                   ? Center(child: Loader())
//                   : announcementList.isEmpty
//                   ? Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "No Community Post Available",
//                         style: TextStyle(
//                           fontSize: 14.5,
//                           color: AppTheme.orangeColor,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: announcementList.length,
//                       itemBuilder: (BuildContext cntx, int index) {
//                         String type = announcementList[index]['type']
//                             .toString();
//                         String startDate = "";
//                         String endDate = "";
//                         String description = "";
//                         String birthdayDescription =
//                             "May this birthday be filled with lots of happy hours and also your life with many happy birthdays that are yet to come. Happy Birthday!!!";
//                         String createdAt = "";
//                         String empName = "";
//                         String userProfileImage = "";
//                         int yearStr = 0;
//                         String yearJSOnStr = "assets/anni_1.json";
//                         String yearCountStr = "";
//                         String AnniverseryStr =
//                             "Thank You for being part of the Journey let's keep on growing together";

//                         startDate = announcementList[index]['start_date']
//                             .toString();
//                         endDate = announcementList[index]['end_date']
//                             .toString();
//                         userProfileImage =
//                             announcementList[index]['profile_photo'].toString();
//                         empName = announcementList[index]['username']
//                             .toString();
//                         description = announcementList[index]['description']
//                             .toString();
//                         createdAt = announcementList[index]['created_at']
//                             .toString();

//                         String WelcomeDescription =
//                             "We are Please to announce that $empName has joined Us";

//                         if (type == 'anniversary') {
//                           yearStr = announcementList[index]['years'];
//                           if (yearStr == 1) {
//                             yearJSOnStr = "assets/anni_1.json";
//                             yearCountStr = "1st Year";
//                           } else if (yearStr == 2) {
//                             yearJSOnStr = "assets/anni_2.json";
//                             yearCountStr = "2nd Year";
//                           } else if (yearStr == 3) {
//                             yearJSOnStr = "assets/anni_3.json";
//                             yearCountStr = "3rd Year";
//                           } else if (yearStr == 4) {
//                             yearJSOnStr = "assets/anni_4.json";
//                             yearCountStr = "4th Year";
//                           } else if (yearStr == 5) {
//                             yearJSOnStr = "assets/anni_5.json";
//                             yearCountStr = "5th Year";
//                           } else if (yearStr == 6) {
//                             yearJSOnStr = "assets/anni_6.json";
//                             yearCountStr = "6th Year";
//                           } else if (yearStr == 7) {
//                             yearJSOnStr = "assets/anni_7.json";
//                             yearCountStr = "7th Year";
//                           } else if (yearStr == 8) {
//                             yearJSOnStr = "assets/anni_8.json";
//                             yearCountStr = "8th Year";
//                           } else if (yearStr == 9) {
//                             yearJSOnStr = "assets/anni_9.json";
//                             yearCountStr = "9th Year";
//                           } else if (yearStr == 10) {
//                             yearJSOnStr = "assets/anni_10.json";
//                             yearCountStr = "10th Year";
//                           } else if (yearStr == 11) {
//                             yearJSOnStr = "assets/anni_11.json";
//                             yearCountStr = "11th Year";
//                           } else if (yearStr == 12) {
//                             yearJSOnStr = "assets/anni_12.json";
//                             yearCountStr = "12th Year";
//                           } else if (yearStr == 13) {
//                             yearJSOnStr = "assets/anni_13.json";
//                             yearCountStr = "13th Year";
//                           } else if (yearStr == 14) {
//                             yearJSOnStr = "assets/anni_14.json";
//                             yearCountStr = "14th Year";
//                           } else if (yearStr == 15) {
//                             yearJSOnStr = "assets/anni_15.json";
//                             yearCountStr = "15th Year";
//                           } else if (yearStr == 16) {
//                             yearJSOnStr = "assets/anni_16.json";
//                             yearCountStr = "16th Year";
//                           } else if (yearStr == 17) {
//                             yearJSOnStr = "assets/anni_17.json";
//                             yearCountStr = "17th Year";
//                           } else if (yearStr == 18) {
//                             yearJSOnStr = "assets/anni_18.json";
//                             yearCountStr = "18th Year";
//                           } else {
//                             yearJSOnStr = "assets/anni_1.json";
//                             yearCountStr = "$yearStr Year";
//                           }
//                         }

//                         if (type == 'welcome_email') {
//                           String department = "";
//                           String designation = "";
//                           if (announcementList[index]['department'] != null) {
//                             department = announcementList[index]['department']
//                                 .toString();
//                           }

//                           if (announcementList[index]['designation'] != null) {
//                             department = announcementList[index]['designation']
//                                 .toString();
//                           }

//                           if (department.isNotEmpty && designation.isNotEmpty) {
//                             WelcomeDescription =
//                                 "We are Please to announce that $empName has joined Us as $designation in $department";
//                           }
//                         }

//                         return Column(
//                           children: [
//                             type == 'announcement'
//                                 ? Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/announc_back_img.png",
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         left: 7,
//                                         right: 10,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Lottie.asset(
//                                                 "assets/announcement.json",
//                                                 width: 100,
//                                                 height: 100,
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   children: [
//                                                     Text(
//                                                       "Announcement",
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color:
//                                                             AppTheme.themeColor,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "$startDate to $endDate",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 14,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           SizedBox(height: 10),
//                                           Text(
//                                             description,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                         ],
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.all(10),
//                                   )
//                                 : type == 'birthday'
//                                 ? Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/birthday_backimg.png",
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         left: 7,
//                                         right: 10,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Lottie.asset(
//                                                 "assets/cake.json",
//                                                 width: 100,
//                                                 height: 150,
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     userProfileImage == ''
//                                                         ? Image.asset(
//                                                             "assets/profile.png",
//                                                             height: 65,
//                                                             width: 40,
//                                                           )
//                                                         : CachedNetworkImage(
//                                                             imageUrl:
//                                                                 userProfileImage,
//                                                             height: 65,
//                                                             width: 40,
//                                                             fit: BoxFit.cover,
//                                                             progressIndicatorBuilder:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   downloadProgress,
//                                                                 ) => CircularProgressIndicator(
//                                                                   value: downloadProgress
//                                                                       .progress,
//                                                                 ),
//                                                             errorWidget:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   error,
//                                                                 ) => const Icon(
//                                                                   Icons.error,
//                                                                 ),
//                                                           ),
//                                                     Text(
//                                                       empName,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: AppTheme
//                                                             .orangeColor,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "Many Many Happy Return of the Day!",
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "$startDate",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           SizedBox(height: 10),
//                                           Text(
//                                             birthdayDescription,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 12,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                         ],
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.all(10),
//                                   )
//                                 : type == 'anniversary'
//                                 ? Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/aniv_back_img.png",
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         left: 7,
//                                         right: 10,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Lottie.asset(
//                                                 yearJSOnStr,
//                                                 width: 100,
//                                                 height: 150,
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     userProfileImage == ''
//                                                         ? Image.asset(
//                                                             "assets/profile.png",
//                                                             height: 65,
//                                                             width: 40,
//                                                           )
//                                                         : CachedNetworkImage(
//                                                             imageUrl:
//                                                                 userProfileImage,
//                                                             height: 65,
//                                                             width: 40,
//                                                             fit: BoxFit.cover,
//                                                             progressIndicatorBuilder:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   downloadProgress,
//                                                                 ) => CircularProgressIndicator(
//                                                                   value: downloadProgress
//                                                                       .progress,
//                                                                 ),
//                                                             errorWidget:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   error,
//                                                                 ) => const Icon(
//                                                                   Icons.error,
//                                                                 ),
//                                                           ),
//                                                     Text(
//                                                       empName,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: AppTheme
//                                                             .orangeColor,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Text(
//                                                           "Happy",
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.w900,
//                                                             fontSize: 12,
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                         SizedBox(width: 5),
//                                                         Text(
//                                                           yearCountStr,
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 14,
//                                                             color: AppTheme
//                                                                 .themeColor,
//                                                           ),
//                                                         ),
//                                                         SizedBox(width: 5),
//                                                         Text(
//                                                           "Anniversary",
//                                                           style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.w900,
//                                                             fontSize: 12,
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "$startDate",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           SizedBox(height: 10),
//                                           Text(
//                                             AnniverseryStr,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 12,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                         ],
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.all(10),
//                                   )
//                                 : type == 'welcome_email'
//                                 ? Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/aniv_back_img.png",
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         left: 7,
//                                         right: 10,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Lottie.asset(
//                                                 "assets/welcome.json",
//                                                 width: 100,
//                                                 height: 150,
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     userProfileImage == ''
//                                                         ? Image.asset(
//                                                             "assets/profile.png",
//                                                             height: 65,
//                                                             width: 40,
//                                                           )
//                                                         : CachedNetworkImage(
//                                                             imageUrl:
//                                                                 userProfileImage,
//                                                             height: 65,
//                                                             width: 40,
//                                                             fit: BoxFit.cover,
//                                                             progressIndicatorBuilder:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   downloadProgress,
//                                                                 ) => CircularProgressIndicator(
//                                                                   value: downloadProgress
//                                                                       .progress,
//                                                                 ),
//                                                             errorWidget:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   error,
//                                                                 ) => const Icon(
//                                                                   Icons.error,
//                                                                 ),
//                                                           ),
//                                                     Text(
//                                                       empName,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: AppTheme
//                                                             .orangeColor,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "Welcome Aboard",
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5),
//                                                     Text(
//                                                       "$startDate",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           SizedBox(height: 10),
//                                           Text(
//                                             description,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 12,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                         ],
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.all(10),
//                                   )
//                                 : type == 'kudos'
//                                 ? Container(
//                                     margin: EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(3),
//                                       color: Colors.white.withOpacity(0.70),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           blurRadius: 6,
//                                           offset: const Offset(
//                                             0,
//                                             0,
//                                           ), // changes position of shadow
//                                         ),
//                                       ],
//                                     ),

//                                     child: Column(
//                                       children: [
//                                         SizedBox(height: 10),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 12,
//                                             right: 6,
//                                           ),
//                                           child: GestureDetector(
//                                             onTap: () {},
//                                             child: Row(
//                                               children: [
//                                                 CircleAvatar(
//                                                   radius: 18,
//                                                   backgroundImage: NetworkImage(
//                                                     announcementList[index]["profile_photo"]
//                                                         .toString(),
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 10),
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         announcementList[index]["username"],
//                                                         style: TextStyle(
//                                                           fontSize: 13,
//                                                           fontFamily: "Poppins",
//                                                           color: AppTheme
//                                                               .communityBlue,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         announcementList[index]["start_date"]
//                                                             .toString(),
//                                                         style: TextStyle(
//                                                           fontSize: 9,
//                                                           fontFamily: "Poppins",
//                                                           color: Color(
//                                                             0xFFB1B1B1,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),

//                                                 SizedBox(width: 10),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 15),

//                                         InkWell(
//                                           onTap: () {},
//                                           child: Container(
//                                             height: 200,
//                                             margin: EdgeInsets.symmetric(
//                                               horizontal: 15,
//                                             ),
//                                             width: double.infinity,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(1),
//                                               image: DecorationImage(
//                                                 fit: BoxFit.cover,
//                                                 image: AssetImage(
//                                                   "assets/community_bg.png",
//                                                 ),
//                                               ),
//                                             ),

//                                             child: Row(
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     Container(
//                                                       width: 155,
//                                                       height: 155,

//                                                       child: Lottie.asset(
//                                                         "assets/comm1.json",
//                                                       ),
//                                                     ),

//                                                     Container(
//                                                       width: 121,
//                                                       height: 32,
//                                                       decoration: BoxDecoration(
//                                                         color: Color(
//                                                           0xFFF2F2F2,
//                                                         ),
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                               4,
//                                                             ),
//                                                         border: Border.all(
//                                                           color: Color(
//                                                             0xFFF47320,
//                                                           ),
//                                                           width: 0.5,
//                                                         ),
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           "100 Points",
//                                                           style: TextStyle(
//                                                             fontSize: 19,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: Color(
//                                                               0xFF304C9F,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),

//                                                 Expanded(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       SizedBox(height: 7),

//                                                       Text(
//                                                         announcementList[index]["department"],
//                                                         style: TextStyle(
//                                                           fontSize: 19,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: AppTheme
//                                                               .orangeColor,
//                                                         ),
//                                                       ),

//                                                       Container(
//                                                         margin:
//                                                             EdgeInsets.symmetric(
//                                                               horizontal: 10,
//                                                             ),
//                                                         child: Divider(),
//                                                       ),

//                                                       /*   SizedBox(height: 4),

//                                       Text(
//                                           "Rohan Singh, Rahul Singh, Neha Sharma",
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w600,
//                                             color:Colors.black,
//                                           )),*/
//                                                       SizedBox(height: 7),

//                                                       Text(
//                                                         announcementList[index]["description"],
//                                                         style: TextStyle(
//                                                           fontSize: 9,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),

//                                         SizedBox(height: 15),
//                                       ],
//                                     ),
//                                   )
//                                 : Container(),
//                             const SizedBox(height: 25),
//                           ],
//                         );
//                       },
//                     ),
//             ],
//           ),
//         ),

//         /************Today's Task Details*******************/
//         SizedBox(height: 15),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: BoxDecoration(color: AppTheme.filterColor),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "Task List",
//                         style: TextStyle(
//                           color: AppTheme.themeColor,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 17.5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),

//                     taskSize > 3
//                         ? InkWell(
//                             onTap: () => {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => AllTask_Screen(false),
//                               //   ),
//                               // ).then((value) => _getDashboardData()),
//                             },
//                             child: Text(
//                               "View All",
//                               style: TextStyle(
//                                 color: AppTheme.orangeColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14.5,
//                               ),
//                             ),
//                           )
//                         : SizedBox(width: 1),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Card(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         elevation: 10,
//                         shadowColor: AppTheme.themeColor,
//                         color: AppTheme.claimCard,
//                         child: Padding(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Open",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: AppTheme.themeColor,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 openTaskCount.toString(),
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w900,
//                                   color: AppTheme.orangeColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Card(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         elevation: 10,
//                         shadowColor: AppTheme.themeColor,
//                         color: AppTheme.claimCard,
//                         child: Padding(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Close",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: AppTheme.themeColor,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 closeTaskCount.toString(),
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w900,
//                                   color: AppTheme.orangeColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => AllTask_Screen(true),
//                           //   ),
//                           // ).then((value) => _getDashboardData());
//                         },
//                         child: Card(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           elevation: 10,
//                           shadowColor: AppTheme.themeColor,
//                           color: AppTheme.claimCard,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Watcher",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppTheme.themeColor,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   watcherCount.toString(),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w900,
//                                     color: AppTheme.orangeColor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),

//                 taskLoading
//                     ? Center(child: Loader())
//                     : taskList.isEmpty
//                     ? Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "No Task Available",
//                           style: TextStyle(
//                             fontSize: 14.5,
//                             color: AppTheme.orangeColor,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: taskList.length,
//                         itemBuilder: (BuildContext cntx, int index) {
//                           var respo = taskList[index];
//                           String taskId = taskList[index]['id'].toString();
//                           String taskTitle = taskList[index]['title']
//                               .toString();
//                           String taskDescription =
//                               taskList[index]['description'].toString();
//                           String taskDueDate = "XXX, 00 XXX 0000";
//                           if (taskList[index]['end_date'] != null) {
//                             var deliveryTime = DateTime.parse(
//                               taskList[index]['end_date'],
//                             );
//                             var delLocal = deliveryTime.toLocal();
//                             taskDueDate = DateFormat(
//                               'E, dd MMM yyyy',
//                             ).format(delLocal);
//                           }
//                           String taskStatus = taskList[index]['task_status']
//                               .toString();
//                           String reporterName = "";
//                           if (taskList[index]['reporter_name'] != null) {
//                             reporterName = taskList[index]['reporter_name']
//                                 .toString();
//                           }
//                           String taskCreatedAt = "";
//                           if (taskList[index]['created_at'] != null) {
//                             var deliveryTime = DateTime.parse(
//                               taskList[index]['created_at'],
//                             );
//                             var delLocal = deliveryTime.toLocal();
//                             taskCreatedAt = DateFormat(
//                               'E, dd MMM yyyy',
//                             ).format(delLocal);
//                           }

//                           String projectName = "";
//                           if (taskList[index]['project_name'] != null) {
//                             projectName = taskList[index]['project_name']
//                                 .toString();
//                             if (taskList[index]['project_key'] != null) {
//                               String key = taskList[index]['project_key']
//                                   .toString();
//                               projectName = "$projectName ($key)";
//                             }
//                           }
//                           var taskbackColor = AppTheme.task_progress_back;
//                           var tasktextColor = AppTheme.task_progress_text;
//                           if (taskStatus == 'Open') {
//                             taskbackColor = AppTheme.task_open_back;
//                             tasktextColor = AppTheme.task_open_text;
//                           } else if (taskStatus == 'Reopened') {
//                             taskbackColor = AppTheme.task_Rejected_back;
//                             tasktextColor = AppTheme.task_Rejected_text;
//                           } else if (taskStatus == 'Close') {
//                             taskbackColor = AppTheme.task_Close_back;
//                             tasktextColor = AppTheme.task_Close_text;
//                           } else if (taskStatus == 'To Do') {
//                             taskbackColor = AppTheme.task_ToDo_back;
//                             tasktextColor = AppTheme.task_ToDo_text;
//                           } else if (taskStatus == 'QA Ready') {
//                             taskbackColor = AppTheme.task_QAReady_back;
//                             tasktextColor = AppTheme.task_QAReady_text;
//                           } else if (taskStatus == 'On Hold') {
//                             taskbackColor = AppTheme.task_OnHold_back;
//                             tasktextColor = AppTheme.task_OnHold_text;
//                           } else if (taskStatus == 'In Progress') {
//                             taskbackColor = AppTheme.task_progress_back;
//                             tasktextColor = AppTheme.task_progress_text;
//                           } else if (taskStatus == 'In Review') {
//                             taskbackColor = AppTheme.task_InReview_back;
//                             tasktextColor = AppTheme.task_InReview_text;
//                           } else if (taskStatus == 'Code Review') {
//                             taskbackColor = AppTheme.task_CodeReview_back;
//                             tasktextColor = AppTheme.task_CodeReview_text;
//                           } else if (taskStatus == 'Done') {
//                             taskbackColor = AppTheme.task_Done_back;
//                             tasktextColor = AppTheme.task_Done_text;
//                           } else if (taskStatus == 'Rejected') {
//                             taskbackColor = AppTheme.task_Rejected_back;
//                             tasktextColor = AppTheme.task_Rejected_text;
//                           } else {
//                             taskbackColor = Colors.black;
//                             tasktextColor = Colors.white;
//                           }
//                           return InkWell(
//                             onTap: () {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) =>
//                               //         TaskDetailsScreen(taskId),
//                               //   ),
//                               // ).then((value) => _getDashboardData());
//                             },
//                             child: Stack(
//                               children: [
//                                 Padding(
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
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(height: 5),
//                                               Text(
//                                                 "Task ID: $taskId",
//                                                 style: TextStyle(
//                                                   color: AppTheme.orangeColor,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 5),
//                                               Text(
//                                                 taskTitle,
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                               Html(
//                                                 data: taskDescription,
//                                                 style: {
//                                                   '#': Style(
//                                                     fontSize: FontSize(12),
//                                                     maxLines: 2,
//                                                     textOverflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 },
//                                               ),
//                                               projectName.isNotEmpty
//                                                   ? Row(
//                                                       children: [
//                                                         Text(
//                                                           "Project:",
//                                                           style: TextStyle(
//                                                             fontSize: 14,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: Colors.grey,
//                                                           ),
//                                                         ),
//                                                         SizedBox(width: 5),
//                                                         Expanded(
//                                                           child: Text(
//                                                             projectName,
//                                                             style: TextStyle(
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                               color: AppTheme
//                                                                   .themeColor,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   : Container(),
//                                               const SizedBox(height: 5),
//                                               Divider(
//                                                 color: Colors.grey,
//                                                 height: 1,
//                                                 thickness: 1.0,
//                                               ),
//                                               const SizedBox(height: 5),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "Created By : ",
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: Text(
//                                                       reporterName,
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 10),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "Created On : ",
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Expanded(
//                                                     child: Text(
//                                                       taskCreatedAt,
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.black,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),

//                                               const SizedBox(height: 10),

//                                               /*Row(
//                                             children: [
//                                               Expanded(child: Container(),
//                                               ),
//                                               SizedBox(width: 5,),
//                                               Expanded(child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text("Task Due Date",style: TextStyle(color: AppTheme.themeColor,fontSize: 12,fontWeight: FontWeight.w500),),
//                                                   SizedBox(height: 5,),
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset('assets/at_calendar.svg',height: 21,width: 18,),
//                                                       SizedBox(width: 5,),
//                                                       Text(taskDueDate,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ))

//                                             ],
//                                           ),
//                                           const SizedBox(height: 10,),*/
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 25),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   right: 0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(1),
//                                       color: taskbackColor,
//                                     ),
//                                     width: 80,
//                                     height: 30,
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         taskStatus,
//                                         style: TextStyle(
//                                           color: tasktextColor,
//                                           fontWeight: FontWeight.w900,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                 SizedBox(height: 10),
//                 TextButton(
//                   onPressed: () {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => AddTask_Screen()),
//                     // ).then((value) => _getDashboardData());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppTheme.PHColor,
//                     ),
//                     height: 45,
//                     child: const Center(
//                       child: Text(
//                         "Add Task",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         /************Leave List*******************/
//         SizedBox(height: 15),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: BoxDecoration(color: AppTheme.filterColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "Leave",
//                         style: TextStyle(
//                           color: AppTheme.themeColor,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 17.5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     leaveSize > 3
//                         ? InkWell(
//                             onTap: () => {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => AppliedLeavesScreen(),
//                               //   ),
//                               // ).then((value) => _getDashboardData()),
//                             },
//                             child: Text(
//                               "View All",
//                               style: TextStyle(
//                                 color: AppTheme.orangeColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14.5,
//                               ),
//                             ),
//                           )
//                         : SizedBox(width: 1),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 leaveLoading
//                     ? Center(child: Loader())
//                     : leaveList.isEmpty
//                     ? Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "No Leave Application Available",
//                           style: TextStyle(
//                             fontSize: 14.5,
//                             color: AppTheme.orangeColor,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: leaveList.length,
//                         itemBuilder: (BuildContext cntx, int index) {
//                           String dStr = "";
//                           String titleStr = "";
//                           String reasonStr = "";

//                           String statusStr = "";
//                           var backColor = AppTheme.task_Done_back;
//                           var textColor = AppTheme.task_Done_text;

//                           var isApproved = 0;
//                           var isCancel = 0;
//                           var isRejected = 0;

//                           if (leaveList[index]['leave_date'] != null) {
//                             var deliveryTime = DateTime.parse(
//                               leaveList[index]['leave_date'],
//                             );
//                             var delLocal = deliveryTime.toLocal();
//                             dStr = DateFormat('MMM d,yyyy').format(delLocal);
//                           }
//                           if (leaveList[index]['leave_status'] != null &&
//                               leaveList[index]['leave_type'] != null) {
//                             titleStr =
//                                 leaveList[index]['leave_status'] +
//                                 " | " +
//                                 leaveList[index]['leave_type'];
//                           }
//                           if (leaveList[index]['reason'] != null) {
//                             reasonStr = leaveList[index]['reason'];
//                           }

//                           if (leaveList[index]['is_approve_status'] != null) {
//                             isApproved = leaveList[index]['is_approve_status'];
//                           }
//                           if (leaveList[index]['is_rejected_status'] != null) {
//                             isRejected = leaveList[index]['is_rejected_status'];
//                           }
//                           if (leaveList[index]['is_cancel'] != null) {
//                             isCancel = leaveList[index]['is_cancel'];
//                           }

//                           if (isApproved == 1) {
//                             statusStr = "Approved";
//                             backColor = AppTheme.task_Done_back;
//                             textColor = AppTheme.task_Done_text;
//                           } else if (isRejected == 1) {
//                             statusStr = "Rejected";
//                             backColor = AppTheme.task_Rejected_back;
//                             textColor = AppTheme.task_Rejected_text;
//                           } else if (isCancel == 1) {
//                             statusStr = "Canceled";
//                             backColor = AppTheme.task_CodeReview_back;
//                             textColor = AppTheme.task_CodeReview_text;
//                           } else {
//                             statusStr = "Pending";
//                             backColor = AppTheme.task_progress_back;
//                             textColor = AppTheme.task_progress_text;
//                           }

//                           return Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 15),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: AppTheme.orangeColor,
//                                           width: 1.0,
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                           left: 7,
//                                           right: 10,
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const SizedBox(height: 5),
//                                             Text(
//                                               titleStr,
//                                               style: TextStyle(
//                                                 color:
//                                                     AppTheme.task_description,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             SizedBox(height: 10),
//                                             Row(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   'assets/at_calendar.svg',
//                                                   height: 21,
//                                                   width: 18,
//                                                 ),
//                                                 SizedBox(width: 5),
//                                                 Text(
//                                                   dStr,
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 10),
//                                             Text(
//                                               reasonStr,
//                                               style: TextStyle(
//                                                 color: AppTheme.leave_type,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 25),
//                                   ],
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(1),
//                                     color: backColor,
//                                   ),
//                                   width: 80,
//                                   height: 30,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       statusStr,
//                                       style: TextStyle(
//                                         color: textColor,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),

//                 SizedBox(height: 10),
//                 TextButton(
//                   onPressed: () {
//                     // clientCode == "MH100"
//                     //     ? Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => MhApplyLeaveScreen(),
//                     //         ),
//                     //       )
//                     //     : Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => ApplyLeave_Screen_UB(),
//                     //         ),
//                     //       );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppTheme.orangeColor,
//                     ),
//                     height: 45,
//                     child: const Center(
//                       child: Text(
//                         "Apply Leave",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // _showAlertDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       title: const Text(
//   //         "Logout",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.red,
//   //           fontSize: 18,
//   //         ),
//   //       ),
//   //       content: const Text(
//   //         "Are you sure you want to Logout ?",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.w300,
//   //           fontSize: 16,
//   //           color: Colors.black,
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () {
//   //             // Navigator.of(ctx).pop();
//   //             // _logOut(context);
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.themeColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Logout",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.greyColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Cancel",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // _logOut(BuildContext context) async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   await preferences.remove("user_id");
//   //   await preferences.remove("email");
//   //   await preferences.remove("designation");
//   //   await preferences.remove("department");
//   //   await preferences.remove("manager");
//   //   await preferences.remove("location");
//   //   await preferences.remove("first_name");
//   //   await preferences.remove("last_name");
//   //   await preferences.remove("role");
//   //   await preferences.remove("full_name");
//   //   await preferences.remove("token");
//   //   await preferences.remove("emp_id");
//   //   await preferences.remove("at_access");
//   //   Navigator.pushAndRemoveUntil(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => LoginScreen()),
//   //     (Route<dynamic> route) => false,
//   //   );
//   // }

//   @override
//   void initState() {
//     // WidgetsBinding.instance?.addObserver(this);
//     super.initState();
//     // Future.delayed(const Duration(milliseconds: 0), () {
//     // _getDashboardData();
//     // });
//     // setupFlutterNotifications();
//   }

//   @override
//   void dispose() {
//     // WidgetsBinding.instance?.removeObserver(this);
//     super.dispose();
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     _getDashboardData();
//   //   }
//   // }

//   // Future<void> setupFlutterNotifications() async {
//   //   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   //   print("FRRR");

//   //   print(FirebaseMessaging.instance.getInitialMessage());
//   //   //  print(FirebaseMessaging.instance.c);

//   //   NotificationSettings settings = await FirebaseMessaging.instance
//   //       .requestPermission(
//   //         announcement: true,
//   //         carPlay: true,
//   //         criticalAlert: true,
//   //         sound: true,
//   //       );

//   //   await FirebaseMessaging.instance.subscribeToTopic('refresh22');
//   //   if (isFlutterLocalNotificationsInitialized) {
//   //     return;
//   //   }
//   //   channel = const AndroidNotificationChannel(
//   //     'high_importance_channel', // id
//   //     'High Importance Notifications', // title
//   //     description:
//   //         'This channel is used for important notifications.', // description
//   //     importance: Importance.high,
//   //   );

//   //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   //   /// Create an Android Notification Channel.
//   //   ///
//   //   /// We use this channel in the `AndroidManifest.xml` file to override the
//   //   /// default FCM channel to enable heads up notifications.
//   //   await flutterLocalNotificationsPlugin!
//   //       .resolvePlatformSpecificImplementation<
//   //         AndroidFlutterLocalNotificationsPlugin
//   //       >()
//   //       ?.createNotificationChannel(channel);

//   //   /// Update the iOS foreground notification presentation options to allow
//   //   /// heads up notifications.
//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //         alert: true,
//   //         badge: true,
//   //         sound: true,
//   //       );
//   //   isFlutterLocalNotificationsInitialized = true;

//   //   FirebaseMessaging.instance.getInitialMessage().then(
//   //     (value) => setState(() {
//   //       print("Get Intial Message");

//   //       print(value?.data.toString());
//   //     }),
//   //   );

//   //   FirebaseMessaging.onMessage.listen(showFlutterNotification);

//   //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //     print('A new onMessageOpenedApp event was published!');
//   //     Navigator.pushNamed(
//   //       context,
//   //       '/message',
//   //       arguments: MessageArguments(message, true),
//   //     );
//   //   });

//   //   print("Firebase connected");
//   // }

//   // void showFlutterNotification(RemoteMessage message) {
//   //   RemoteNotification? notification = message.notification;
//   //   AndroidNotification? android = message.notification?.android;
//   //   AppleNotification? apple = message.notification?.apple;
//   //   if (notification != null) {
//   //     if (android != null) {
//   //       flutterLocalNotificationsPlugin?.show(
//   //         notification.hashCode,
//   //         notification.title,
//   //         notification.body,
//   //         NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //             'default_channel_id',
//   //             'Default Channel',
//   //             channelDescription: 'Default Channel Description',
//   //             icon: 'launch_background',
//   //           ),
//   //         ),
//   //       );
//   //     } else if (apple != null) {
//   //       flutterLocalNotificationsPlugin?.show(
//   //         notification.hashCode,
//   //         notification.title,
//   //         notification.body,

//   //         NotificationDetails(
//   //           iOS: DarwinNotificationDetails(
//   //             presentAlert: true,
//   //             presentBadge: true,
//   //             presentSound: true,
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   }
//   // }

//   // _getDashboardData() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   userIdStr = await MyUtils.getSharedPreferences("user_id") ?? "";
//   //   fullNameStr = await MyUtils.getSharedPreferences("full_name") ?? "";
//   //   token = await MyUtils.getSharedPreferences("token") ?? "";
//   //   designationStr = await MyUtils.getSharedPreferences("designation") ?? "";
//   //   empId = await MyUtils.getSharedPreferences("emp_id") ?? "";
//   //   baseUrl = await MyUtils.getSharedPreferences("base_url") ?? "";
//   //   clientCode = await MyUtils.getSharedPreferences("client_code") ?? "";
//   //   String? access = await MyUtils.getSharedPreferences("at_access") ?? '1';
//   //   isAttendanceAccess = access;

//   //   if (Platform.isAndroid) {
//   //     platform = "Android";
//   //   } else if (Platform.isIOS) {
//   //     platform = "iOS";
//   //   } else {
//   //     platform = "Other";
//   //   }

//   //   print("userId:-" + userIdStr.toString());
//   //   print("token:-" + token.toString());
//   //   print("employee_id:-" + empId.toString());
//   //   print("Base Url:-" + baseUrl.toString());
//   //   print("Platform:-" + platform);
//   //   print("Client Code:-" + clientCode);

//   //   Navigator.of(context).pop();

//   //   getAttendanceDetails();
//   //   _getLastAttendance();
//   //   getLocationList();
//   //   getTaskList();
//   //   getLeaves();
//   //   getAnnouncements();
//   //   if (clientCode == 'QD100') {
//   //     getCorrectionNotification();
//   //   }
//   // }

//   // imageSelector(BuildContext context) async {
//   //   imageFile = await ImagePicker().pickImage(
//   //     source: ImageSource.camera,
//   //     imageQuality: 60,
//   //     preferredCameraDevice: CameraDevice.front,
//   //   );

//   //   if (imageFile != null) {
//   //     file = File(imageFile!.path);

//   //     final imageFiles = imageFile;
//   //     if (imageFiles != null) {
//   //       print("You selected  image : " + imageFiles.path.toString());
//   //       setState(() {
//   //         debugPrint("SELECTED IMAGE PICK   $imageFiles");
//   //       });
//   //       _faceDetection();
//   //     } else {
//   //       print("You have not taken image");
//   //     }
//   //   } else {
//   //     Toast.show(
//   //       "Unable to capture Image. Please try Again...",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // _faceFromCamera() async {
//   //   APIDialog.showAlertDialog(context, "Detecting Face....");
//   //   final image = InputImage.fromFile(capturedFile!);
//   //   final faces = await _faceDetector.processImage(image);
//   //   print("faces in image ${faces.length}");
//   //   Navigator.pop(context);
//   //   if (faces.isNotEmpty) {
//   //     // _showImageDialog();
//   //     _showCameraImageDialog();
//   //   } else {
//   //     Toast.show(
//   //       "Face not detected in captured image. Please capture a selfie.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _showFaceErrorCustomDialog();
//   //   }
//   // }

//   // _faceDetection() async {
//   //   APIDialog.showAlertDialog(context, "Detecting Face....");

//   //   final image = InputImage.fromFile(file!);
//   //   final faces = await _faceDetector.processImage(image);
//   //   print("faces in image ${faces.length}");
//   //   Navigator.pop(context);
//   //   if (faces.isNotEmpty) {
//   //     _showImageDialog();
//   //   } else {
//   //     Toast.show(
//   //       "Face not detected in captured image. Please capture a selfie.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _showFaceErrorCustomDialog();
//   //   }
//   // }

//   // _showCameraImageDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       title: const Text(
//   //         "Mark Attendance",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.red,
//   //           fontSize: 18,
//   //         ),
//   //       ),
//   //       content: Container(
//   //         width: double.infinity,
//   //         height: 300,
//   //         decoration: BoxDecoration(
//   //           color: Colors.grey,
//   //           shape: BoxShape.rectangle,
//   //           image: DecorationImage(
//   //             image: FileImage(capturedFile!),
//   //             fit: BoxFit.cover,
//   //           ),
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //             // markAttendance();
//   //             //markAttendanceFromCamera();
//   //             markOnlyAttendance("camera");
//   //             //call attendance punch in or out
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.themeColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Mark",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.greyColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Cancel",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // _showImageDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       title: const Text(
//   //         "Mark Attendance",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.red,
//   //           fontSize: 18,
//   //         ),
//   //       ),
//   //       content: Container(
//   //         width: double.infinity,
//   //         height: 300,
//   //         decoration: BoxDecoration(
//   //           color: Colors.grey,
//   //           shape: BoxShape.rectangle,
//   //           image: DecorationImage(image: FileImage(file!), fit: BoxFit.cover),
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //             // markAttendance();
//   //             markOnlyAttendance("iOS");
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.themeColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Mark",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.greyColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Cancel",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // getAttendanceDetails() async {
//   //   setState(() {
//   //     attStatus = true;
//   //   });
//   //   //APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? baseUrl = prefs.getString('base_url') ?? '';
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'attendance_management/attendanceBasicDetails',
//   //     token,
//   //     context,
//   //   );
//   //   //Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     String sAttendanceTypeServer =
//   //         responseJSON['data']['attendance_basic_details']['attendance_type']
//   //             .toString();
//   //     if (sAttendanceTypeServer == "attendance") {
//   //       String last_check_status =
//   //           responseJSON['data']['attendance_basic_details']['last_check_status']
//   //               .toString();
//   //       String lastImg =
//   //           responseJSON['data']['attendance_basic_details']['last_check_capture']
//   //               .toString();
//   //       if (last_check_status == "null") {
//   //         logedInTime = "00:00:00";
//   //         showCheckIn = true;
//   //       } else if (last_check_status == "in") {
//   //         showCheckIn = false;
//   //         logedInTime =
//   //             responseJSON['data']['attendance_basic_details']['total_time']
//   //                 .toString();

//   //         if (logedInTime == "null") {
//   //           logedInTime = "00:00:00";
//   //         }
//   //         startTimer(logedInTime);
//   //       } else if (last_check_status == "out") {
//   //         showCheckIn = true;
//   //         logedInTime =
//   //             responseJSON['data']['attendance_basic_details']['total_time']
//   //                 .toString();
//   //         if (logedInTime == "null") {
//   //           logedInTime = "00:00:00";
//   //         }
//   //         stopTimer();
//   //       }

//   //       if (lastImg != "null" && lastImg != "no_cam") {
//   //         if (lastImg.contains("data:image")) {
//   //           String lmg = lastImg.replaceAll("data:image/png;base64,", '');
//   //           lastImage = lmg.replaceAll("data:image/jpeg;base64,", '');
//   //           isUrl = false;
//   //         } else {
//   //           lastImage = lastImg;
//   //           isUrl = true;
//   //         }
//   //       }
//   //     } else {
//   //       showCheckIn = true;
//   //     }
//   //     /*if(clientCode=="EN100"){
//   //         if(!showCheckIn && !shStartSite && !shSiteCheckIn && !shSiteCheckOut && !shEndSite){

//   //           shStartSite=true;
//   //         }
//   //       }*/
//   //     setState(() {
//   //       attStatus = false;
//   //     });
//   //     if (clientCode == 'EN100') {
//   //       getSiteDetails();
//   //     }
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       attStatus = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       attStatus = false;
//   //     });
//   //   }
//   // }

//   // getLocationList() async {
//   //   // APIDialog.showAlertDialog(context, "Please wait...");
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithBase(
//   //     baseUrl,
//   //     "rest_api/get-project-location-by-empid?empId=" + userIdStr,
//   //     context,
//   //   );
//   //   // Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     if (responseJSON['latLngRadius'] != null) {
//   //       int ltRadus = responseJSON['latLngRadius'];
//   //       locationRadius = ltRadus + 1;
//   //     }

//   //     print('Location Radius $locationRadius');

//   //     locationList = responseJSON['data'];
//   //     for (int i = 0; i < locationList.length; i++) {
//   //       print("lofgubh : " + locationList[i]['lat']);
//   //       print("lnghsg : " + locationList[i]['lng']);
//   //     }

//   //     setState(() {
//   //       //isLoading=false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       //isLoading=false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );

//   //     setState(() {
//   //       //isLoading=false;
//   //     });
//   //   }
//   // }

//   // /************Location Services******************/
//   // Future<void> prepairCamera() async {
//   //   // imageSelector(context);

//   //   if (Platform.isAndroid) {
//   //     final imageData = await Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => MarkAttendanceScreen()),
//   //     );
//   //     if (imageData != null) {
//   //       capturedImage = imageData;
//   //       capturedFile = File(capturedImage!.path);

//   //       _faceFromCamera();
//   //       //_showCameraImageDialog();
//   //     } else {
//   //       Toast.show(
//   //         "Unable to capture Image. Please try Again...",
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } else {
//   //     imageSelector(context);
//   //   }
//   // }

//   // Future<bool> _handleCameraPermission() async {
//   //   bool serviceEnabled;
//   //   PermissionStatus status = await Permission.camera.status;
//   //   if (status.isGranted) {
//   //     serviceEnabled = true;
//   //   } else if (status.isPermanentlyDenied) {
//   //     serviceEnabled = false;
//   //   } else {
//   //     var camStatus = await Permission.camera.request();
//   //     if (camStatus.isGranted) {
//   //       serviceEnabled = true;
//   //     } else {
//   //       serviceEnabled = false;
//   //     }
//   //   }
//   //   return serviceEnabled;
//   // }

//   // Future<bool> _handleLocationPermission() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     Toast.show(
//   //       "Location services are disabled. Please enable the services.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //         content: Text(
//   //             'Location services are disabled. Please enable the services')));*/
//   //     return false;
//   //   }
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       Toast.show(
//   //         "Location permissions are denied.",
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //       /*ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(content: Text('Location permissions are denied')));*/
//   //       return false;
//   //     }
//   //   }
//   //   if (permission == LocationPermission.deniedForever) {
//   //     Toast.show(
//   //       "Location permissions are permanently denied, we cannot request permissions.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //         content: Text(
//   //             'Location permissions are permanently denied, we cannot request permissions.')));*/
//   //     return false;
//   //   }

//   //   return true;
//   // }

//   // _checkDeveloperOptionForCheck() async {
//   //   bool isDevelopment = false;
//   //   bool isMockLocation = false;
//   //   if (Platform.isAndroid) {
//   //     try {
//   //       isDevelopment = await FlutterJailbreakDetection.developerMode;
//   //       print("is Development Mode Enabled $isDevelopment");
//   //     } on PlatformException catch (e) {
//   //       print("Platform Error ${e.message}");
//   //     }
//   //   }
//   //   if (isDevelopment || isMockLocation) {
//   //     _showSettingDialog(isDevelopment, isMockLocation);
//   //   } else {
//   //     _checkValidationForSiteCheck();
//   //   }
//   // }

//   // _checkValidationForSiteCheck() {
//   //   if (clientCode == 'EN100') {
//   //     if (!showCheckIn) {
//   //       if (shStartSite) {
//   //         _getCurrentPosition();
//   //       } else {
//   //         Toast.show(
//   //           "Please End the Site Visit First!!!",
//   //           duration: Toast.lengthLong,
//   //           gravity: Toast.bottom,
//   //           backgroundColor: Colors.red,
//   //         );
//   //       }
//   //     } else {
//   //       _getCurrentPosition();
//   //     }
//   //   } else {
//   //     _getCurrentPosition();
//   //   }
//   // }

//   // Future<void> _getCurrentPosition() async {
//   //   APIDialog.showAlertDialog(context, "Fetching Location..");
//   //   final hasPermission = await _handleLocationPermission();
//   //   if (!hasPermission) {
//   //     Navigator.of(context).pop();
//   //     _showPermissionCustomDialog();
//   //     return;
//   //   }
//   //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//   //       .then((Position position) {
//   //         setState(() => _currentPosition = position);
//   //         print(
//   //           "Location  latitude : ${_currentPosition!.latitude} Longitude : ${_currentPosition!.longitude}",
//   //         );
//   //         Navigator.pop(context);
//   //         print("Is Location  Mocked: ${position.isMocked}");
//   //         if (position.isMocked) {
//   //           _showMockLocationDialog();
//   //         } else {
//   //           _getAddressFromLatLng(position);
//   //         }
//   //       })
//   //       .catchError((e) {
//   //         debugPrint(e);
//   //         Toast.show(
//   //           "Error!!! Can't get Location. Please Ensure your location services are enabled",
//   //           duration: Toast.lengthLong,
//   //           gravity: Toast.bottom,
//   //           backgroundColor: Colors.red,
//   //         );
//   //         Navigator.pop(context);
//   //       });
//   // }

//   // Future<void> _getAddressFromLatLng(Position position) async {
//   //   APIDialog.showAlertDialog(context, "Checking Location....");

//   //   bool isLocationMatched = false;
//   //   double distancePoints = 0.0;
//   //   print("Location Length ${locationList.length}");

//   //   if (locationList.isNotEmpty) {
//   //     for (int i = 0; i < locationList.length; i++) {
//   //       double lat1 = double.parse(locationList[i]['lat'].toString());
//   //       double long1 = double.parse(locationList[i]['lng'].toString());
//   //       distancePoints = Geolocator.distanceBetween(
//   //         lat1,
//   //         long1,
//   //         position.latitude,
//   //         position.longitude,
//   //       );
//   //       print("distance calculated:::$distancePoints Meter");
//   //       if (distancePoints < locationRadius) {
//   //         isLocationMatched = true;
//   //         break;
//   //       }
//   //     }
//   //   } else {
//   //     isLocationMatched = true;
//   //   }

//   //   Navigator.pop(context);
//   //   if (isLocationMatched) {
//   //     prepairCamera();
//   //   } else {
//   //     String distanceStr = "";
//   //     if (distancePoints < 1000) {
//   //       distanceStr = "${distancePoints.toStringAsFixed(2)} Meters";
//   //     } else {
//   //       double ddsss = distancePoints / 1000;
//   //       distanceStr = "${ddsss.toStringAsFixed(2)} Kms";
//   //     }
//   //     _showLocationErrorCustomDialog(distanceStr);
//   //   }

//   //   /* await placemarkFromCoordinates(
//   //       _currentPosition!.latitude, _currentPosition!.longitude)
//   //       .then((List<Placemark> placemarks) {
//   //     Placemark place = placemarks[0];
//   //     setState(() {
//   //       _currentAddress='${place.name},${place.street},${place.subLocality},${place.locality},${place.thoroughfare},${place.subThoroughfare},${place.subAdministrativeArea},${place.administrativeArea},${place.country}, ${place.postalCode}';
//   //     });
//   //     print("Current Address : "+_currentAddress!);
//   //     bool isLocationMatched=false;
//   //     double distancePoints=0.0;
//   //     print("Location Length ${locationList.length}");

//   //     if(locationList.isNotEmpty) {
//   //       for (int i = 0; i < locationList.length; i++) {
//   //         double lat1 = double.parse(locationList[i]['lat'].toString());
//   //         double long1 = double.parse(locationList[i]['lng'].toString());
//   //         distancePoints = Geolocator.distanceBetween(
//   //             lat1, long1, position.latitude, position.longitude);
//   //         print("distance calculated:::$distancePoints Meter");
//   //         if (distancePoints < locationRadius) {
//   //           isLocationMatched = true;
//   //           break;
//   //         }
//   //       }
//   //     }else{
//   //       isLocationMatched = true;
//   //     }

//   //     Navigator.pop(context);
//   //     if(isLocationMatched){
//   //       prepairCamera();
//   //     }else{

//   //       String distanceStr="";
//   //       if(distancePoints<1000){
//   //         distanceStr="${distancePoints.toStringAsFixed(2)} Meters";
//   //       }else{
//   //         double ddsss=distancePoints/1000;
//   //         distanceStr="${ddsss.toStringAsFixed(2)} Kms";
//   //       }

//   //       _showLocationErrorCustomDialog(distanceStr);
//   //     }

//   //   }).catchError((e) {
//   //     debugPrint(e.toString());
//   //     prepairCamera();
//   //   });*/
//   // }

//   // /***********Mark Attendance*****************/
//   // markAttendanceFromCamera() async {
//   //   String attendanceCheck = "";
//   //   String addressStr = "";
//   //   if (showCheckIn) {
//   //     attendanceCheck = "in";
//   //   } else {
//   //     attendanceCheck = "out";
//   //   }
//   //   /*if(_currentAddress!=null){
//   //     addressStr=_currentAddress!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   APIDialog.showAlertDialog(context, 'Submitting Attendance...');

//   //   final bytes = await File(capturedFile!.path).readAsBytesSync();
//   //   String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
//   //   print("imagePan $base64Image");
//   //   print("Base Url $baseUrl");
//   //   print("Check Status $attendanceCheck");
//   //   print("emp_user_id $userIdStr");

//   //   var requestModel = {
//   //     "emp_user_id": userIdStr,
//   //     "latitude": _currentPosition!.latitude.toString(),
//   //     "longitude": _currentPosition!.longitude.toString(),
//   //     "status": "status",
//   //     "attendance_check_status": attendanceCheck,
//   //     "attendance_type": "attendance",
//   //     "attendance_check_location": addressStr,
//   //     "capture": base64Image,
//   //     "device": platform,
//   //     "mac_address": "flutter",
//   //     "other_break_time": "00:00:00:00",
//   //     "comment": "flutter",
//   //   };
//   //   ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//   //   var response = await apiBaseHelper.postAPIWithHeader(
//   //     baseUrl,
//   //     "attendance_management/attendanceCheckInCheckOut",
//   //     requestModel,
//   //     context,
//   //     token,
//   //   );

//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.green,
//   //     );
//   //     _showCustomDialog();
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // markAttendance() async {
//   //   String attendanceCheck = "";
//   //   String addressStr = "";
//   //   if (showCheckIn) {
//   //     attendanceCheck = "in";
//   //   } else {
//   //     attendanceCheck = "out";
//   //   }
//   //   /*if(_currentAddress!=null){
//   //     addressStr=_currentAddress!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   APIDialog.showAlertDialog(context, 'Submitting Attendance...');

//   //   final bytes = await File(file!.path).readAsBytesSync();
//   //   String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
//   //   print("imagePan $base64Image");
//   //   print("Base Url $baseUrl");
//   //   print("Check Status $attendanceCheck");
//   //   print("emp_user_id $userIdStr");

//   //   var requestModel = {
//   //     "emp_user_id": userIdStr,
//   //     "latitude": _currentPosition!.latitude.toString(),
//   //     "longitude": _currentPosition!.longitude.toString(),
//   //     "status": "status",
//   //     "attendance_check_status": attendanceCheck,
//   //     "attendance_type": "attendance",
//   //     "attendance_check_location": addressStr,
//   //     "capture": base64Image,
//   //     "device": platform,
//   //     "mac_address": "flutter",
//   //     "other_break_time": "00:00:00:00",
//   //     "comment": "flutter",
//   //   };
//   //   ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//   //   var response = await apiBaseHelper.postAPIWithHeader(
//   //     baseUrl,
//   //     "attendance_management/attendanceCheckInCheckOut",
//   //     requestModel,
//   //     context,
//   //     token,
//   //   );

//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.green,
//   //     );
//   //     _showCustomDialog();
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // _getLastAttendance() async {
//   //   setState(() {
//   //     lastAttendance = true;
//   //   });
//   //   var now = DateTime.now();
//   //   var now_1w = now.subtract(const Duration(days: 7));
//   //   var now_last = now.subtract(const Duration(days: 1));
//   //   var startDate = DateFormat('yyyy-MM-dd').format(now_1w);
//   //   var lastDate = DateFormat('yyyy-MM-dd').format(now_last);
//   //   print("Start Date: $startDate");
//   //   print("Last Date: $lastDate");
//   //   print("Employee Id: $empId");
//   //   // APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   var requestModel = {
//   //     "emp_id": empId,
//   //     "start_date": startDate,
//   //     "last_date": lastDate,
//   //   };
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.postAPI(
//   //     baseUrl,
//   //     'attendance_management/get-attendance-by-id',
//   //     requestModel,
//   //     context,
//   //   );
//   //   // Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     List<dynamic> tempUserList = [];
//   //     tempUserList = responseJSON['data'];
//   //     attendanceDate.clear();
//   //     for (int i = 0; i < tempUserList.length; i++) {
//   //       String dateStr = tempUserList[i]['date'];
//   //       String first_half_status = tempUserList[i]['first_half_status'];
//   //       String second_half_status = tempUserList[i]['second_half_status'];
//   //       String first_check_in = tempUserList[i]['first_check_in'];
//   //       String last_check_out = tempUserList[i]['last_check_out'];
//   //       String total_time = tempUserList[i]['total_time'];
//   //       String attendance_status = tempUserList[i]['attendance_status'];
//   //       String attendance_day = "";
//   //       if (tempUserList[i]['attendance_day'] != null) {
//   //         attendance_day = tempUserList[i]['attendance_day'];
//   //       }
//   //       var atDate = DateTime.parse(dateStr);
//   //       var nDate = DateFormat("ddMMM").format(atDate);
//   //       double attendanceHour = 8;
//   //       if (attendance_status == "HD" ||
//   //           attendance_status == "first_half_present" ||
//   //           attendance_status == "FHP" ||
//   //           attendance_status == "SHP" ||
//   //           attendance_status == "second_half_present" ||
//   //           attendance_status == "PH_FHP" ||
//   //           attendance_status == "PH_SHP" ||
//   //           attendance_status == "WO_FHP" ||
//   //           attendance_status == "WO_SHP") {
//   //         attendanceHour = 4;
//   //       }
//   //       attendanceDate.add(
//   //         AttendanceSeries(
//   //           nDate,
//   //           first_half_status,
//   //           second_half_status,
//   //           first_check_in,
//   //           last_check_out,
//   //           total_time,
//   //           attendance_status,
//   //           attendance_day,
//   //           i,
//   //           attendanceHour,
//   //         ),
//   //       );
//   //     }
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }

//   //   setState(() {
//   //     lastAttendance = false;
//   //   });
//   // }

//   // _showCustomDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(20.0),
//   //         ), //this right here
//   //         child: Container(
//   //           height: 300,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(12.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Align(
//   //                   alignment: Alignment.centerRight,
//   //                   child: InkWell(
//   //                     onTap: () {
//   //                       Navigator.of(context).pop();
//   //                       getAttendanceDetails();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.close_rounded,
//   //                       color: Colors.red,
//   //                       size: 20,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 Container(
//   //                   height: 100,
//   //                   width: double.infinity,
//   //                   child: Lottie.asset("assets/att_anim.json"),
//   //                 ),
//   //                 SizedBox(height: 10),
//   //                 Align(
//   //                   alignment: Alignment.center,
//   //                   child: Text(
//   //                     "Time Marked!!!",
//   //                     style: TextStyle(
//   //                       color: AppTheme.orangeColor,
//   //                       fontWeight: FontWeight.w900,
//   //                       fontSize: 18,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                     getAttendanceDetails();
//   //                     //call attendance punch in or out
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       color: AppTheme.themeColor,
//   //                     ),
//   //                     height: 45,
//   //                     padding: const EdgeInsets.all(10),
//   //                     child: const Center(
//   //                       child: Text(
//   //                         "Done",
//   //                         style: TextStyle(
//   //                           fontWeight: FontWeight.w500,
//   //                           fontSize: 14,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // startTimer(String time) {
//   //   List<String> splitString = time.split(':');
//   //   int hour = int.parse(splitString[0]);
//   //   int mnts = int.parse(splitString[1]);
//   //   int sec = int.parse(splitString[2]);

//   //   myDuration = Duration(hours: hour, minutes: mnts, seconds: sec);
//   //   if (countdownTimer != null) {
//   //     countdownTimer!.cancel();
//   //   }
//   //   countdownTimer = Timer.periodic(
//   //     const Duration(seconds: 1),
//   //     (_) => setCountDown(),
//   //   );
//   // }

//   // setCountDown() {
//   //   const increasedSecBy = 1;
//   //   setState(() {
//   //     final second = myDuration!.inSeconds + increasedSecBy;
//   //     myDuration = Duration(seconds: second);
//   //     String strDigits(int n) => n.toString().padLeft(2, '0');
//   //     final hours = strDigits(myDuration!.inHours.remainder(24));
//   //     final minutes = strDigits(myDuration!.inMinutes.remainder(60));
//   //     final seconds = strDigits(myDuration!.inSeconds.remainder(60));
//   //     logedInTime = "$hours:$minutes:$seconds";
//   //   });
//   // }

//   // stopTimer() {
//   //   if (countdownTimer != null) {
//   //     countdownTimer!.cancel();
//   //   }
//   // }

//   // _showPermissionCustomDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(20.0),
//   //         ), //this right here
//   //         child: Container(
//   //           height: 300,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(12.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Align(
//   //                   alignment: Alignment.centerRight,
//   //                   child: InkWell(
//   //                     onTap: () {
//   //                       Navigator.of(context).pop();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.close_rounded,
//   //                       color: Colors.red,
//   //                       size: 20,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 Text(
//   //                   "Please allow below permissions for access the Attendance Functionality.",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 10),
//   //                 Text(
//   //                   "1.) Location Permission",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 5),
//   //                 Text(
//   //                   "2.) Enable GPS Services",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),

//   //                 SizedBox(height: 20),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                     //call attendance punch in or out
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       color: AppTheme.themeColor,
//   //                     ),
//   //                     height: 45,
//   //                     padding: const EdgeInsets.all(10),
//   //                     child: const Center(
//   //                       child: Text(
//   //                         "OK",
//   //                         style: TextStyle(
//   //                           fontWeight: FontWeight.w500,
//   //                           fontSize: 14,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // _showCameraPermissionCustomDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(20.0),
//   //         ), //this right here
//   //         child: Container(
//   //           height: 300,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(12.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Align(
//   //                   alignment: Alignment.centerRight,
//   //                   child: InkWell(
//   //                     onTap: () {
//   //                       Navigator.of(context).pop();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.close_rounded,
//   //                       color: Colors.red,
//   //                       size: 20,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 Text(
//   //                   "Please allow Camera Permissions For Capture Image",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),

//   //                 SizedBox(height: 20),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                     //call attendance punch in or out
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       color: AppTheme.themeColor,
//   //                     ),
//   //                     height: 45,
//   //                     padding: const EdgeInsets.all(10),
//   //                     child: const Center(
//   //                       child: Text(
//   //                         "OK",
//   //                         style: TextStyle(
//   //                           fontWeight: FontWeight.w500,
//   //                           fontSize: 14,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // _showFaceErrorCustomDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(20.0),
//   //         ), //this right here
//   //         child: Container(
//   //           height: 300,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(12.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Align(
//   //                   alignment: Alignment.centerRight,
//   //                   child: InkWell(
//   //                     onTap: () {
//   //                       Navigator.of(context).pop();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.close_rounded,
//   //                       color: Colors.red,
//   //                       size: 20,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 Text(
//   //                   "Please capture Selfie!!!",
//   //                   style: TextStyle(
//   //                     color: Colors.red,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 18,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),

//   //                 Text(
//   //                   "Face not detected in captured Image. Please capture Selfie.",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                     //call attendance punch in or out
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       color: AppTheme.themeColor,
//   //                     ),
//   //                     height: 45,
//   //                     padding: const EdgeInsets.all(10),
//   //                     child: const Center(
//   //                       child: Text(
//   //                         "OK",
//   //                         style: TextStyle(
//   //                           fontWeight: FontWeight.w500,
//   //                           fontSize: 14,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // _showLocationErrorCustomDialog(String distanceStr) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(20.0),
//   //         ), //this right here
//   //         child: Container(
//   //           height: 300,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(12.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Align(
//   //                   alignment: Alignment.centerRight,
//   //                   child: InkWell(
//   //                     onTap: () {
//   //                       Navigator.of(context).pop();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.close_rounded,
//   //                       color: Colors.red,
//   //                       size: 20,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 Text(
//   //                   "Location Not Matched !",
//   //                   style: TextStyle(
//   //                     color: Colors.red,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 18,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),

//   //                 Text(
//   //                   "You are not Allowed to Check-In OR Check-Out on this Location. You are $distanceStr away from required Location.",
//   //                   style: TextStyle(
//   //                     color: Colors.black,
//   //                     fontWeight: FontWeight.w900,
//   //                     fontSize: 14,
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 20),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                     //call attendance punch in or out
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                       color: AppTheme.themeColor,
//   //                     ),
//   //                     height: 45,
//   //                     padding: const EdgeInsets.all(10),
//   //                     child: const Center(
//   //                       child: Text(
//   //                         "OK",
//   //                         style: TextStyle(
//   //                           fontWeight: FontWeight.w500,
//   //                           fontSize: 14,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   Image imageFromBase64String(String base64String) {
//     return Image.memory(
//       base64Decode(base64String),
//       fit: BoxFit.cover,
//       width: 70,
//       height: 70,
//       gaplessPlayback: true,
//     );
//   }

//   // /****************tasks/get-tasks**************/
//   // getTaskList() async {
//   //   setState(() {
//   //     taskLoading = true;
//   //   });
//   //   //APIDialog.showAlertDialog(context, "Please wait...");
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     "tasks/get-tasks",
//   //     token,
//   //     context,
//   //   );
//   //   // Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     totakTaskList.clear();
//   //     taskList.clear();

//   //     totakTaskList = responseJSON['data']['data'];
//   //     taskSize = totakTaskList.length;

//   //     if (totakTaskList.length > 3) {
//   //       taskList.add(totakTaskList[0]);
//   //       taskList.add(totakTaskList[1]);
//   //       taskList.add(totakTaskList[2]);
//   //     } else {
//   //       taskList.addAll(totakTaskList);
//   //     }

//   //     openTaskCount = 0;
//   //     closeTaskCount = 0;
//   //     watcherCount = 0;
//   //     if (responseJSON['data']['watchersCount'] != null) {
//   //       watcherCount = responseJSON['data']['watchersCount'];
//   //     }

//   //     if (responseJSON['data']['statusCount'] != null) {
//   //       List<dynamic> statuscount = responseJSON['data']['statusCount'];
//   //       for (int j = 0; j < statuscount.length; j++) {
//   //         String status = statuscount[j]['status'].toString();
//   //         int count = statuscount[j]['count'];
//   //         if (status == 'Open' ||
//   //             status == 'Reopened' ||
//   //             status == 'In Progress' ||
//   //             status == 'Re-Assign') {
//   //           openTaskCount = openTaskCount + count;
//   //         } else if (status == 'Close' ||
//   //             status == 'Done' ||
//   //             status == 'Rejected') {
//   //           closeTaskCount = closeTaskCount + count;
//   //         }
//   //       }
//   //     } else {
//   //       for (int i = 0; i < totakTaskList.length; i++) {
//   //         if (totakTaskList[i]['task_status'] != null) {
//   //           if (totakTaskList[i]['task_status'] == 'Open' ||
//   //               totakTaskList[i]['task_status'] == 'Reopened' ||
//   //               totakTaskList[i]['task_status'] == 'In Progress' ||
//   //               totakTaskList[i]['task_status'] == 'Re-Assign') {
//   //             openTaskCount = openTaskCount + 1;
//   //           } else if (totakTaskList[i]['task_status'] == 'Close' ||
//   //               totakTaskList[i]['task_status'] == 'Done' ||
//   //               totakTaskList[i]['task_status'] == 'Rejected') {
//   //             closeTaskCount = closeTaskCount + 1;
//   //           }
//   //         }
//   //       }
//   //     }

//   //     setState(() {
//   //       taskLoading = false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       taskLoading = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );

//   //     setState(() {
//   //       taskLoading = false;
//   //     });
//   //   }
//   // }

//   // /****************get Applied Leaves**************/
//   // getLeaves() async {
//   //   setState(() {
//   //     leaveLoading = true;
//   //   });
//   //   //APIDialog.showAlertDialog(context, "Please wait...");
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     "attendance_management/getEmpAppliedApplication?type=leave&request_for=applied",
//   //     token,
//   //     context,
//   //   );
//   //   // Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     totalLeaveList.clear();
//   //     leaveList.clear();

//   //     totalLeaveList = responseJSON['data'];
//   //     leaveSize = totalLeaveList.length;
//   //     if (totalLeaveList.length > 3) {
//   //       leaveList.add(totalLeaveList[0]);
//   //       leaveList.add(totalLeaveList[1]);
//   //       leaveList.add(totalLeaveList[2]);
//   //     } else {
//   //       leaveList.addAll(totalLeaveList);
//   //     }

//   //     setState(() {
//   //       leaveLoading = false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       leaveLoading = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );

//   //     setState(() {
//   //       leaveLoading = false;
//   //     });
//   //   }
//   // }

//   // /************get Camera for Capture Image******************/
//   // markOnlyAttendance(String from) async {
//   //   String attendanceCheck = "";
//   //   String addressStr = "";
//   //   if (showCheckIn) {
//   //     attendanceCheck = "in";
//   //   } else {
//   //     attendanceCheck = "out";
//   //   }
//   //   /*if(_currentAddress!=null){
//   //     addressStr=_currentAddress!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/
//   //   APIDialog.showAlertDialog(context, 'Submitting Attendance...');

//   //   //final bytes= await File(file!.path).readAsBytesSync();
//   //   // String base64Image="data:image/jpeg;base64,"+base64Encode(bytes);
//   //   // print("imagePan $base64Image");
//   //   print("Base Url $baseUrl");
//   //   print("Check Status $attendanceCheck");
//   //   print("emp_user_id $userIdStr");

//   //   var requestModel = {
//   //     "emp_user_id": userIdStr,
//   //     "latitude": _currentPosition!.latitude.toString(),
//   //     "longitude": _currentPosition!.longitude.toString(),
//   //     "status": "status",
//   //     "attendance_check_status": attendanceCheck,
//   //     "attendance_type": "attendance",
//   //     "attendance_check_location": addressStr,
//   //     // "capture":base64Image,
//   //     "device": platform,
//   //     "mac_address": "flutter",
//   //     "other_break_time": "00:00:00:00",
//   //     "comment": "flutter",
//   //   };
//   //   ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//   //   var response = await apiBaseHelper.postAPIWithHeader(
//   //     baseUrl,
//   //     "attendance_management/attendanceCheckInCheckOutMobile",
//   //     requestModel,
//   //     context,
//   //     token,
//   //   );

//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.green,
//   //     );
//   //     if (responseJSON['data']['insertId'] != null) {
//   //       String id = responseJSON['data']['insertId'].toString();
//   //       uploadOnlyImage(from, id);
//   //     } else {
//   //       getAttendanceDetails();
//   //     }
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // uploadOnlyImage(String from, String id) async {
//   //   setState(() {
//   //     isImageUploading = true;
//   //   });
//   //   APIDialog.showAlertDialog(context, 'Uploading Image...');
//   //   var bytes = null;

//   //   if (from == 'camera') {
//   //     bytes = await File(capturedFile!.path).readAsBytesSync();
//   //   } else {
//   //     bytes = await File(file!.path).readAsBytesSync();
//   //   }
//   //   String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
//   //   var requestModel = {"id": id, "capture": base64Image, "device": platform};
//   //   ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//   //   var response = await apiBaseHelper.postAPIWithHeader(
//   //     baseUrl,
//   //     "attendance_management/updateImageAttendance",
//   //     requestModel,
//   //     context,
//   //     token,
//   //   );
//   //   Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   if (responseJSON['error'] == false) {
//   //     /*Toast.show(responseJSON['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green);*/

//   //     getAttendanceDetails();
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }

//   //   setState(() {
//   //     isImageUploading = false;
//   //   });
//   // }

//   // getAnnouncements() async {
//   //   final now = DateTime.now();
//   //   var date = now.subtract(Duration(days: 10));
//   //   var startDate = DateFormat("yyyy-MM-dd").format(date);
//   //   var endDate = DateFormat("yyyy-MM-dd").format(now);

//   //   print("start Date : $startDate");
//   //   print("End Date : $endDate");

//   //   setState(() {
//   //     communityLoading = true;
//   //   });
//   //   //APIDialog.showAlertDialog(context, 'Please Wait...');
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? baseUrl = prefs.getString('base_url') ?? '';
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'rest_api/get-all-announcements?start_date=$startDate&end_date=$endDate',
//   //     token,
//   //     context,
//   //   );
//   //   //Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);

//   //   if (responseJSON['error'] == false) {
//   //     announcementList.clear();

//   //     List<dynamic> tempList = [];
//   //     tempList = responseJSON['data'];

//   //     announcementSize = tempList.length;

//   //     if (tempList.length > 3) {
//   //       for (int i = tempList.length - 1; i >= tempList.length - 3; i--) {
//   //         announcementList.add(tempList[i]);
//   //       }
//   //     } else {
//   //       for (int i = tempList.length - 1; i >= 0; i--) {
//   //         announcementList.add(tempList[i]);
//   //       }
//   //     }

//   //     //announcementList=responseJSON['data'];

//   //     setState(() {
//   //       communityLoading = false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       communityLoading = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       communityLoading = false;
//   //     });
//   //   }
//   // }

//   // /************Correction Notification************************/
//   // getCorrectionNotification() async {
//   //   setState(() {
//   //     isNotiLoading = true;
//   //   });
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'rest_api/get-correction-notification',
//   //     token,
//   //     context,
//   //   );
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     List<dynamic> tempDataList = responseJSON['data'];
//   //     notiStr = "";

//   //     if (tempDataList.isNotEmpty) {
//   //       String samplenotiStr = tempDataList[0]['message'].toString();
//   //       notiStr = Bidi.stripHtmlIfNeeded(samplenotiStr);
//   //     }

//   //     setState(() {
//   //       isNotiLoading = false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       isNotiLoading = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     Toast.show(
//   //       responseJSON['message'],
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       isNotiLoading = false;
//   //     });
//   //   }
//   // }

//   // _checkDeveloperOption() async {
//   //   bool isDevelopment = false;
//   //   bool isMockLocation = false;
//   //   if (Platform.isAndroid) {
//   //     try {
//   //       isDevelopment = await FlutterJailbreakDetection.developerMode;
//   //       print("is Development Mode Enabled $isDevelopment");
//   //     } on PlatformException catch (e) {
//   //       print("Platform Error ${e.message}");
//   //     }
//   //   }
//   //   if (isDevelopment || isMockLocation) {
//   //     _showSettingDialog(isDevelopment, isMockLocation);
//   //   } else {
//   //     _getCurrentPositionForSite();
//   //   }
//   // }

//   // _showSettingDialog(bool isDevelopment, bool isMockLocation) {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (ctx) => PopScope(
//   //       canPop: false,
//   //       child: AlertDialog(
//   //         title: const Text(
//   //           "WARNING",
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(
//   //             fontWeight: FontWeight.bold,
//   //             color: Colors.red,
//   //             fontSize: 18,
//   //           ),
//   //         ),
//   //         content: Container(
//   //           height: 400,
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.center,
//   //             children: [
//   //               Container(
//   //                 height: 100,
//   //                 margin: const EdgeInsets.only(top: 30),
//   //                 child: Center(
//   //                   child: Lottie.asset("assets/warning_anim.json"),
//   //                 ),
//   //               ),
//   //               SizedBox(height: 10),

//   //               Text(
//   //                 isDevelopment && isMockLocation
//   //                     ? "Please Turn Off the Development Mode and Mock Location Applications"
//   //                     : isDevelopment && !isMockLocation
//   //                     ? "Please Turn Off the Development Mode."
//   //                     : !isDevelopment && isMockLocation
//   //                     ? "Please Uninstall or Turn Off the Mock Location Applications"
//   //                     : "",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w700,
//   //                   fontSize: 14,
//   //                   color: AppTheme.orangeColor,
//   //                 ),
//   //               ),

//   //               SizedBox(height: 10),

//   //               const Text(
//   //                 "This application use device real locations In Some Functionalities So Please TURN OFF the Development Mode or Mock Location Applications.\n Please follow the path: Settings > Search For Developer Option > Toggle the switch to Off",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 16,
//   //                   color: Colors.black,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.of(ctx).pop();
//   //               redirectToSettings();
//   //             },
//   //             child: Container(
//   //               decoration: BoxDecoration(
//   //                 borderRadius: BorderRadius.circular(10),
//   //                 color: AppTheme.themeColor,
//   //               ),
//   //               height: 45,
//   //               padding: const EdgeInsets.all(10),
//   //               child: const Center(
//   //                 child: Text(
//   //                   "Go To Settings",
//   //                   style: TextStyle(
//   //                     fontWeight: FontWeight.w500,
//   //                     fontSize: 14,
//   //                     color: Colors.white,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // _showMockLocationDialog() {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (ctx) => PopScope(
//   //       canPop: false,
//   //       child: AlertDialog(
//   //         title: const Text(
//   //           "WARNING",
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(
//   //             fontWeight: FontWeight.bold,
//   //             color: Colors.red,
//   //             fontSize: 18,
//   //           ),
//   //         ),
//   //         content: Container(
//   //           height: 400,
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.center,
//   //             children: [
//   //               Container(
//   //                 height: 100,
//   //                 margin: const EdgeInsets.only(top: 30),
//   //                 child: Center(
//   //                   child: Lottie.asset("assets/warning_anim.json"),
//   //                 ),
//   //               ),
//   //               SizedBox(height: 10),

//   //               Text(
//   //                 "Please Turn Off Mock Location or Mock Location Application.",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w700,
//   //                   fontSize: 14,
//   //                   color: AppTheme.orangeColor,
//   //                 ),
//   //               ),

//   //               SizedBox(height: 10),

//   //               const Text(
//   //                 "You are using the Mock Location or Mock Location Application. You need to Turn Off Mock Location for Use This Functionality. For Turn Off Mock Location Please follow These Steps. Settings > Search For Developer Option > Search For Select Mock Location App > Select NOTHING",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 16,
//   //                   color: Colors.black,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.of(ctx).pop();
//   //               redirectToSettings();
//   //             },
//   //             child: Container(
//   //               decoration: BoxDecoration(
//   //                 borderRadius: BorderRadius.circular(10),
//   //                 color: AppTheme.themeColor,
//   //               ),
//   //               height: 45,
//   //               padding: const EdgeInsets.all(10),
//   //               child: const Center(
//   //                 child: Text(
//   //                   "Go To Settings",
//   //                   style: TextStyle(
//   //                     fontWeight: FontWeight.w500,
//   //                     fontSize: 14,
//   //                     color: Colors.white,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // redirectToSettings() {
//   //   AppSettings.openAppSettings(type: AppSettingsType.device);
//   // }

//   // /*************Site Visit Functionality For EduNextG*************/
//   // Future<void> _getCurrentPositionForSite() async {
//   //   APIDialog.showAlertDialog(context, "Fetching Location..");
//   //   final hasPermission = await _handleLocationPermission();
//   //   if (!hasPermission) {
//   //     Navigator.of(context).pop();
//   //     _showPermissionCustomDialog();
//   //     return;
//   //   }
//   //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//   //       .then((Position position) {
//   //         setState(() => _currentPositionSite = position);
//   //         print(
//   //           "Location  latitude : ${_currentPositionSite!.latitude} Longitude : ${_currentPositionSite!.longitude}",
//   //         );
//   //         Navigator.pop(context);
//   //         print("Is Location  Mocked: ${position.isMocked}");
//   //         if (position.isMocked) {
//   //           _showMockLocationDialog();
//   //         } else {
//   //           _getAddressFromLatLngSite(position);
//   //         }
//   //       })
//   //       .catchError((e) {
//   //         debugPrint(e);
//   //         Toast.show(
//   //           "Error!!! Can't get Location. Please Ensure your location services are enabled",
//   //           duration: Toast.lengthLong,
//   //           gravity: Toast.bottom,
//   //           backgroundColor: Colors.red,
//   //         );
//   //         Navigator.pop(context);
//   //       });
//   // }

//   // Future<void> _getAddressFromLatLngSite(Position position) async {
//   //   APIDialog.showAlertDialog(context, "Fetching Address....");
//   //   //print("Current Address Site : "+_currentAddressSite!);
//   //   bool isLocationMatched = false;
//   //   double distancePoints = 0.0;
//   //   print("Location Length ${locationList.length}");
//   //   isLocationMatched = true;
//   //   Navigator.pop(context);
//   //   if (isLocationMatched) {
//   //     if (subType == 'start' || subType == 'end') {
//   //       markSiteVisitWithoutImage();
//   //     } else {
//   //       prepairCameraSite();
//   //     }
//   //   }
//   //   /*await placemarkFromCoordinates(
//   //       position.latitude, position.longitude)
//   //       .then((List<Placemark> placemarks) {
//   //     Placemark place = placemarks[0];
//   //     setState(() {
//   //       _currentAddressSite='${place.name},${place.street},${place.subLocality},${place.locality},${place.thoroughfare},${place.subThoroughfare},${place.subAdministrativeArea},${place.administrativeArea},${place.country}, ${place.postalCode}';
//   //     });
//   //     print("Current Address Site : "+_currentAddressSite!);
//   //     bool isLocationMatched=false;
//   //     double distancePoints=0.0;
//   //     print("Location Length ${locationList.length}");
//   //     isLocationMatched = true;
//   //     Navigator.pop(context);
//   //     if(isLocationMatched){

//   //       if(subType=='start' || subType == 'end'){
//   //         markSiteVisitWithoutImage();
//   //       }else{
//   //         prepairCameraSite();
//   //       }

//   //     }
//   //   }).catchError((e) {
//   //     debugPrint(e.toString());
//   //     if(subType=='start' || subType == 'end'){
//   //       markSiteVisitWithoutImage();
//   //     }else{
//   //       prepairCameraSite();
//   //     }
//   //   });*/
//   // }

//   // Future<void> prepairCameraSite() async {
//   //   if (Platform.isAndroid) {
//   //     final imageData = await Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => MarkAttendanceScreen()),
//   //     );
//   //     if (imageData != null) {
//   //       capturedImageSite = imageData;
//   //       capturedFileSite = File(capturedImageSite!.path);
//   //       _faceFromCameraSite();
//   //       /* if(subType=="in"){
//   //         _showSiteCheckInForAndroid();
//   //       }else{
//   //         _showCameraImageDialogSite();
//   //       }*/
//   //     } else {
//   //       Toast.show(
//   //         "Unable to capture Image. Please try Again...",
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } else {
//   //     imageSelectorSite(context);
//   //   }
//   // }

//   // _faceFromCameraSite() async {
//   //   APIDialog.showAlertDialog(context, "Detecting Face....");
//   //   final image = InputImage.fromFile(capturedFileSite!);
//   //   final faces = await _faceDetector.processImage(image);
//   //   print("faces in image ${faces.length}");
//   //   Navigator.pop(context);
//   //   if (faces.isNotEmpty) {
//   //     if (subType == "in") {
//   //       _showSiteCheckInForAndroid();
//   //     } else {
//   //       _showCameraImageDialogSite();
//   //     }
//   //   } else {
//   //     Toast.show(
//   //       "Face not detected in captured image. Please capture a selfie.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _showFaceErrorCustomDialog();
//   //   }
//   // }

//   // imageSelectorSite(BuildContext context) async {
//   //   imageFileSite = await ImagePicker().pickImage(
//   //     source: ImageSource.camera,
//   //     imageQuality: 60,
//   //     preferredCameraDevice: CameraDevice.front,
//   //   );

//   //   if (imageFileSite != null) {
//   //     fileSite = File(imageFileSite!.path);
//   //     final imageFiles = imageFileSite;
//   //     if (imageFiles != null) {
//   //       print("You selected  image : " + imageFiles.path.toString());
//   //       setState(() {
//   //         debugPrint("SELECTED IMAGE PICK   $imageFiles");
//   //       });
//   //       _faceDetectionSite();
//   //       //_showImageDialogSite();
//   //     } else {
//   //       print("You have not taken image");
//   //     }
//   //   } else {
//   //     Toast.show(
//   //       "Unable to capture Image. Please try Again...",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // _faceDetectionSite() async {
//   //   APIDialog.showAlertDialog(context, "Detecting Face....");

//   //   final image = InputImage.fromFile(fileSite!);
//   //   final faces = await _faceDetector.processImage(image);
//   //   print("faces in image ${faces.length}");
//   //   Navigator.pop(context);
//   //   if (faces.isNotEmpty) {
//   //     if (subType == "in") {
//   //       _showSiteCheckInForiOS();
//   //     } else {
//   //       _showImageDialogSite();
//   //     }
//   //   } else {
//   //     Toast.show(
//   //       "Face not detected in captured image. Please capture a selfie.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     _showFaceErrorCustomDialog();
//   //   }
//   // }

//   // _showCameraImageDialogSite() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       title: const Text(
//   //         "Mark Site Visit",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.red,
//   //           fontSize: 18,
//   //         ),
//   //       ),
//   //       content: Container(
//   //         width: double.infinity,
//   //         height: 300,
//   //         decoration: BoxDecoration(
//   //           color: Colors.grey,
//   //           shape: BoxShape.rectangle,
//   //           image: DecorationImage(
//   //             image: FileImage(capturedFileSite!),
//   //             fit: BoxFit.cover,
//   //           ),
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //             markSiteVisitForAndroid();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.themeColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Mark",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.greyColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Cancel",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // _showImageDialogSite() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       title: const Text(
//   //         "Mark Site Visit",
//   //         style: TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.red,
//   //           fontSize: 18,
//   //         ),
//   //       ),
//   //       content: Container(
//   //         width: double.infinity,
//   //         height: 300,
//   //         decoration: BoxDecoration(
//   //           color: Colors.grey,
//   //           shape: BoxShape.rectangle,
//   //           image: DecorationImage(
//   //             image: FileImage(fileSite!),
//   //             fit: BoxFit.cover,
//   //           ),
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();

//   //             markSiteVisitForiOS();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.themeColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Mark",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(ctx).pop();
//   //           },
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               color: AppTheme.greyColor,
//   //             ),
//   //             height: 45,
//   //             padding: const EdgeInsets.all(10),
//   //             child: const Center(
//   //               child: Text(
//   //                 "Cancel",
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.w500,
//   //                   fontSize: 14,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // markSiteVisitForiOS() async {
//   //   APIDialog.showAlertDialog(context, 'Marking Site Visit...');
//   //   String fileName = imageFileSite!.path.split('/').last;
//   //   String extension = fileName.split('.').last;
//   //   String addressStr = "";
//   //   /*if(_currentAddressSite!=null){
//   //     addressStr=_currentAddressSite!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   print(fileName);
//   //   FormData formData = FormData.fromMap({
//   //     "file": await MultipartFile.fromFile(imageFile!.path, filename: fileName),
//   //     "emp_id": empId,
//   //     "type": "site_visiting",
//   //     "sub_type": subType,
//   //     "site_name": "",
//   //     "lat": _currentPositionSite!.latitude.toString(),
//   //     "lng": _currentPositionSite!.longitude.toString(),
//   //     "location": addressStr,
//   //   });
//   //   String apiUrl = baseUrl + "common_api/add-site-visit";
//   //   print(apiUrl);

//   //   Dio dio = Dio();
//   //   dio.options.headers['Content-Type'] = 'multipart/form-data';
//   //   dio.options.headers['X-Auth-Token'] = token;
//   //   try {
//   //     var response = await dio.post(apiUrl, data: formData);
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data['error'] == false) {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green,
//   //       );
//   //       getSiteDetails();
//   //     } else {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } on DioError catch (e) {
//   //     print(e);
//   //     print(e.response.toString());
//   //     Navigator.pop(context);
//   //     Toast.show(
//   //       e.message,
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // markSiteVisitForAndroid() async {
//   //   APIDialog.showAlertDialog(context, 'Marking Site Visit...');
//   //   String fileName = capturedFileSite!.path.split('/').last;
//   //   String extension = fileName.split('.').last;
//   //   String addressStr = "";
//   //   /*if(_currentAddressSite!=null){
//   //     addressStr=_currentAddressSite!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   print(fileName);
//   //   FormData formData = FormData.fromMap({
//   //     "file": await MultipartFile.fromFile(
//   //       capturedFileSite!.path,
//   //       filename: fileName,
//   //     ),
//   //     "emp_id": empId,
//   //     "type": "site_visiting",
//   //     "sub_type": subType,
//   //     "site_name": "",
//   //     "lat": _currentPositionSite!.latitude.toString(),
//   //     "lng": _currentPositionSite!.longitude.toString(),
//   //     "location": addressStr,
//   //   });
//   //   String apiUrl = baseUrl + "common_api/add-site-visit";
//   //   print(apiUrl);

//   //   Dio dio = Dio();
//   //   dio.options.headers['Content-Type'] = 'multipart/form-data';
//   //   dio.options.headers['X-Auth-Token'] = token;
//   //   try {
//   //     var response = await dio.post(apiUrl, data: formData);
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data['error'] == false) {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green,
//   //       );

//   //       getSiteDetails();
//   //     } else {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } on DioError catch (e) {
//   //     print(e);
//   //     print(e.response.toString());
//   //     Navigator.pop(context);
//   //     Toast.show(
//   //       e.message,
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // getSiteDetails() async {
//   //   setState(() {
//   //     siteStatus = true;
//   //   });
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? baseUrl = prefs.getString('base_url') ?? '';
//   //   ApiBaseHelper helper = ApiBaseHelper();
//   //   var response = await helper.getWithToken(
//   //     baseUrl,
//   //     'common_api/get-site-visit?emp_id=$empId',
//   //     token,
//   //     context,
//   //   );
//   //   //Navigator.pop(context);
//   //   var responseJSON = json.decode(response.body);
//   //   print(responseJSON);
//   //   if (responseJSON['error'] == false) {
//   //     List<dynamic> tempList = responseJSON['data']['lastEntry'];
//   //     if (tempList.isNotEmpty) {
//   //       String subType = tempList[0]['sub_type'].toString();
//   //       print("************************$subType");
//   //       if (subType == 'start') {
//   //         showStartVisit = false;
//   //         showSiteCheckIn = true;

//   //         shStartSite = false;
//   //         shSiteCheckOut = false;
//   //         shSiteCheckIn = true;
//   //         shEndSite = true;
//   //       } else if (subType == 'in') {
//   //         showStartVisit = false;
//   //         showSiteCheckIn = false;

//   //         shStartSite = false;
//   //         shSiteCheckOut = true;
//   //         shSiteCheckIn = false;
//   //         shEndSite = false;
//   //       } else if (subType == 'out') {
//   //         showStartVisit = false;
//   //         showSiteCheckIn = true;

//   //         shStartSite = false;
//   //         shSiteCheckOut = false;
//   //         shSiteCheckIn = true;
//   //         shEndSite = true;
//   //       } else if (subType == 'end') {
//   //         showStartVisit = true;
//   //         showSiteCheckIn = false;
//   //         if (!showCheckIn) {
//   //           shStartSite = true;
//   //         } else {
//   //           shStartSite = false;
//   //         }
//   //         shSiteCheckOut = false;
//   //         shSiteCheckIn = false;
//   //         shEndSite = false;
//   //       }
//   //     } else {
//   //       showStartVisit = true;
//   //       showSiteCheckIn = false;

//   //       print("Show Check In $showCheckIn");

//   //       if (!showCheckIn) {
//   //         shStartSite = true;
//   //         shSiteCheckOut = false;
//   //         shSiteCheckIn = false;
//   //         shEndSite = false;
//   //       } else {
//   //         shStartSite = false;
//   //         shSiteCheckOut = false;
//   //         shSiteCheckIn = false;
//   //         shEndSite = false;
//   //       }

//   //       print("Show Start Site $shStartSite");
//   //     }

//   //     setState(() {
//   //       siteStatus = false;
//   //     });
//   //   } else if (responseJSON['code'] == 401 ||
//   //       responseJSON['message'] == 'Invalid token.') {
//   //     Toast.show(
//   //       "Your Login session is Expired!! Please login again.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //     setState(() {
//   //       siteStatus = false;
//   //     });
//   //     _logOut(context);
//   //   } else {
//   //     showStartVisit = true;
//   //     showSiteCheckIn = false;
//   //     /*Toast.show(responseJSON['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red);*/
//   //     if (!showCheckIn) {
//   //       shStartSite = true;
//   //       shSiteCheckOut = false;
//   //       shSiteCheckIn = false;
//   //       shEndSite = false;
//   //     } else {
//   //       shStartSite = false;
//   //       shSiteCheckOut = false;
//   //       shSiteCheckIn = false;
//   //       shEndSite = false;
//   //     }

//   //     setState(() {
//   //       siteStatus = false;
//   //     });
//   //   }
//   // }

//   // markSiteVisitWithoutImage() async {
//   //   APIDialog.showAlertDialog(context, 'Marking Site Visit...');
//   //   String addressStr = "";
//   //   /*if(_currentAddressSite!=null){
//   //     addressStr=_currentAddressSite!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   FormData formData = FormData.fromMap({
//   //     "file": "",
//   //     "emp_id": empId,
//   //     "type": "site_visiting",
//   //     "sub_type": subType,
//   //     "site_name": "",
//   //     "lat": _currentPositionSite!.latitude.toString(),
//   //     "lng": _currentPositionSite!.longitude.toString(),
//   //     "location": addressStr,
//   //   });
//   //   String apiUrl = baseUrl + "common_api/add-site-visit";
//   //   print(apiUrl);

//   //   Dio dio = Dio();
//   //   dio.options.headers['Content-Type'] = 'multipart/form-data';
//   //   dio.options.headers['X-Auth-Token'] = token;
//   //   try {
//   //     var response = await dio.post(apiUrl, data: formData);
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data['error'] == false) {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green,
//   //       );

//   //       getSiteDetails();
//   //     } else {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } on DioError catch (e) {
//   //     print(e);
//   //     print(e.response.toString());
//   //     Navigator.pop(context);
//   //     Toast.show(
//   //       e.message,
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // /*************Site Check in Confirmation*******************/

//   // _showSiteCheckInForAndroid() {
//   //   cameraSiteName.text = "";
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     builder: (BuildContext contx) {
//   //       return StatefulBuilder(
//   //         builder: (ctx, setDialogState) {
//   //           return Padding(
//   //             padding: MediaQuery.of(contx).viewInsets,
//   //             child: Container(
//   //               width: double.infinity,
//   //               decoration: const BoxDecoration(
//   //                 shape: BoxShape.rectangle,
//   //                 color: Colors.white,
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(25),
//   //                   topRight: Radius.circular(25),
//   //                 ),
//   //               ),
//   //               child: SingleChildScrollView(
//   //                 child: Column(
//   //                   mainAxisSize: MainAxisSize.min,
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     const SizedBox(height: 20),
//   //                     Align(
//   //                       alignment: Alignment.center,
//   //                       child: Container(
//   //                         height: 5,
//   //                         width: 30,
//   //                         color: AppTheme.greyColor,
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 10),
//   //                     Padding(
//   //                       padding: EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Row(
//   //                         children: [
//   //                           Expanded(
//   //                             child: Text(
//   //                               "Mark Site Check-In",
//   //                               style: TextStyle(
//   //                                 fontWeight: FontWeight.w900,
//   //                                 color: Colors.black,
//   //                                 fontSize: 18.5,
//   //                               ),
//   //                             ),
//   //                           ),
//   //                           const SizedBox(width: 5),
//   //                           InkWell(
//   //                             onTap: () {
//   //                               Navigator.of(context).pop();
//   //                             },
//   //                             child: const Icon(
//   //                               Icons.close_rounded,
//   //                               color: AppTheme.greyColor,
//   //                               size: 32,
//   //                             ),
//   //                           ),
//   //                           const SizedBox(width: 5),
//   //                         ],
//   //                       ),
//   //                     ),

//   //                     const SizedBox(height: 10),
//   //                     Container(
//   //                       width: double.infinity,
//   //                       height: 300,
//   //                       decoration: BoxDecoration(
//   //                         color: Colors.grey,
//   //                         shape: BoxShape.rectangle,
//   //                         image: DecorationImage(
//   //                           image: FileImage(capturedFileSite!),
//   //                           fit: BoxFit.cover,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     SizedBox(height: 10),
//   //                     const Padding(
//   //                       padding: EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Text(
//   //                         "Enter Site Name",
//   //                         style: TextStyle(
//   //                           fontSize: 16,
//   //                           fontWeight: FontWeight.w900,
//   //                           color: AppTheme.themeColor,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     Padding(
//   //                       padding: const EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Container(
//   //                         decoration: BoxDecoration(
//   //                           color: Colors.white,
//   //                           border: Border.all(
//   //                             color: Colors.black,
//   //                             width: 1,
//   //                             style: BorderStyle.solid,
//   //                           ),
//   //                           borderRadius: const BorderRadius.all(
//   //                             Radius.circular(5),
//   //                           ),
//   //                         ),
//   //                         child: Padding(
//   //                           padding: EdgeInsets.symmetric(horizontal: 10),
//   //                           child: Center(
//   //                             child: TextField(
//   //                               minLines: 1,
//   //                               maxLines: 3,
//   //                               keyboardType: TextInputType.multiline,
//   //                               controller: cameraSiteName,
//   //                               maxLength: 100,
//   //                               autofocus: true,
//   //                               decoration: InputDecoration(
//   //                                 border: InputBorder.none,
//   //                               ),
//   //                               focusNode: _focusNode,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 10),
//   //                     TextButton(
//   //                       onPressed: () {
//   //                         _validationSiteCheckInCamera();
//   //                       },
//   //                       child: Container(
//   //                         decoration: BoxDecoration(
//   //                           borderRadius: BorderRadius.circular(10),
//   //                           color: AppTheme.themeColor,
//   //                         ),
//   //                         height: 40,
//   //                         padding: const EdgeInsets.only(
//   //                           left: 10,
//   //                           right: 10,
//   //                           top: 5,
//   //                           bottom: 5,
//   //                         ),
//   //                         child: Center(
//   //                           child: Text(
//   //                             "Mark",
//   //                             style: const TextStyle(
//   //                               fontWeight: FontWeight.w900,
//   //                               fontSize: 16,
//   //                               color: Colors.white,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //           );
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   // _validationSiteCheckInCamera() {
//   //   String reasonStr = cameraSiteName.text.toString();
//   //   if (reasonStr.isNotEmpty) {
//   //     _focusNode.unfocus();
//   //     Navigator.of(context).pop();
//   //     markSiteCheckInAndroid(reasonStr);
//   //   } else {
//   //     Toast.show(
//   //       "Please Enter Site Name.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // markSiteCheckInAndroid(String siteName) async {
//   //   APIDialog.showAlertDialog(context, 'Marking Site Visit...');
//   //   String fileName = capturedFileSite!.path.split('/').last;
//   //   String extension = fileName.split('.').last;
//   //   String addressStr = "";
//   //   /*if(_currentAddressSite!=null){
//   //     addressStr=_currentAddressSite!;
//   //   }else{
//   //     addressStr="Address Not Available";
//   //   }*/

//   //   print(fileName);
//   //   FormData formData = FormData.fromMap({
//   //     "file": await MultipartFile.fromFile(
//   //       capturedFileSite!.path,
//   //       filename: fileName,
//   //     ),
//   //     "emp_id": empId,
//   //     "type": "site_visiting",
//   //     "sub_type": subType,
//   //     "site_name": siteName,
//   //     "lat": _currentPositionSite!.latitude.toString(),
//   //     "lng": _currentPositionSite!.longitude.toString(),
//   //     "location": addressStr,
//   //   });
//   //   String apiUrl = baseUrl + "common_api/add-site-visit";
//   //   print(apiUrl);
//   //   Dio dio = Dio();
//   //   dio.options.headers['Content-Type'] = 'multipart/form-data';
//   //   dio.options.headers['X-Auth-Token'] = token;
//   //   try {
//   //     var response = await dio.post(apiUrl, data: formData);
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data['error'] == false) {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green,
//   //       );
//   //       getSiteDetails();
//   //     } else {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } on DioError catch (e) {
//   //     print(e);
//   //     print(e.response.toString());
//   //     Navigator.pop(context);
//   //     Toast.show(
//   //       e.message,
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // _showSiteCheckInForiOS() {
//   //   cameraSiteName.text = "";
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     builder: (BuildContext contx) {
//   //       return StatefulBuilder(
//   //         builder: (ctx, setDialogState) {
//   //           return Padding(
//   //             padding: MediaQuery.of(contx).viewInsets,
//   //             child: Container(
//   //               width: double.infinity,
//   //               decoration: const BoxDecoration(
//   //                 shape: BoxShape.rectangle,
//   //                 color: Colors.white,
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(25),
//   //                   topRight: Radius.circular(25),
//   //                 ),
//   //               ),
//   //               child: SingleChildScrollView(
//   //                 child: Column(
//   //                   mainAxisSize: MainAxisSize.min,
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     const SizedBox(height: 20),
//   //                     Align(
//   //                       alignment: Alignment.center,
//   //                       child: Container(
//   //                         height: 5,
//   //                         width: 30,
//   //                         color: AppTheme.greyColor,
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 10),
//   //                     Padding(
//   //                       padding: EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Row(
//   //                         children: [
//   //                           Expanded(
//   //                             child: Text(
//   //                               "Mark Site Check-In",
//   //                               style: TextStyle(
//   //                                 fontWeight: FontWeight.w900,
//   //                                 color: Colors.black,
//   //                                 fontSize: 18.5,
//   //                               ),
//   //                             ),
//   //                           ),
//   //                           const SizedBox(width: 5),
//   //                           InkWell(
//   //                             onTap: () {
//   //                               Navigator.of(context).pop();
//   //                             },
//   //                             child: const Icon(
//   //                               Icons.close_rounded,
//   //                               color: AppTheme.greyColor,
//   //                               size: 32,
//   //                             ),
//   //                           ),
//   //                           const SizedBox(width: 5),
//   //                         ],
//   //                       ),
//   //                     ),

//   //                     const SizedBox(height: 10),
//   //                     Container(
//   //                       width: double.infinity,
//   //                       height: 300,
//   //                       decoration: BoxDecoration(
//   //                         color: Colors.grey,
//   //                         shape: BoxShape.rectangle,
//   //                         image: DecorationImage(
//   //                           image: FileImage(capturedFileSite!),
//   //                           fit: BoxFit.cover,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     SizedBox(height: 10),
//   //                     const Padding(
//   //                       padding: EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Text(
//   //                         "Enter Site Name",
//   //                         style: TextStyle(
//   //                           fontSize: 16,
//   //                           fontWeight: FontWeight.w900,
//   //                           color: AppTheme.themeColor,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     Padding(
//   //                       padding: const EdgeInsets.symmetric(horizontal: 10),
//   //                       child: Container(
//   //                         decoration: BoxDecoration(
//   //                           color: Colors.white,
//   //                           border: Border.all(
//   //                             color: Colors.black,
//   //                             width: 1,
//   //                             style: BorderStyle.solid,
//   //                           ),
//   //                           borderRadius: const BorderRadius.all(
//   //                             Radius.circular(5),
//   //                           ),
//   //                         ),
//   //                         child: Padding(
//   //                           padding: EdgeInsets.symmetric(horizontal: 10),
//   //                           child: Center(
//   //                             child: TextField(
//   //                               minLines: 1,
//   //                               maxLines: 3,
//   //                               keyboardType: TextInputType.multiline,
//   //                               controller: cameraSiteName,
//   //                               maxLength: 100,
//   //                               autofocus: true,
//   //                               decoration: InputDecoration(
//   //                                 border: InputBorder.none,
//   //                               ),
//   //                               focusNode: _focusNode,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 10),
//   //                     TextButton(
//   //                       onPressed: () {
//   //                         _validationSiteCheckIniOS();
//   //                       },
//   //                       child: Container(
//   //                         decoration: BoxDecoration(
//   //                           borderRadius: BorderRadius.circular(10),
//   //                           color: AppTheme.themeColor,
//   //                         ),
//   //                         height: 40,
//   //                         padding: const EdgeInsets.only(
//   //                           left: 10,
//   //                           right: 10,
//   //                           top: 5,
//   //                           bottom: 5,
//   //                         ),
//   //                         child: Center(
//   //                           child: Text(
//   //                             "Mark",
//   //                             style: const TextStyle(
//   //                               fontWeight: FontWeight.w900,
//   //                               fontSize: 16,
//   //                               color: Colors.white,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //           );
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   // _validationSiteCheckIniOS() {
//   //   String reasonStr = cameraSiteName.text.toString();
//   //   if (reasonStr.isNotEmpty) {
//   //     _focusNode.unfocus();
//   //     Navigator.of(context).pop();
//   //     markSiteCheckIniOS(reasonStr);
//   //   } else {
//   //     Toast.show(
//   //       "Please Enter Site Name.",
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }

//   // markSiteCheckIniOS(String siteName) async {
//   //   APIDialog.showAlertDialog(context, 'Marking Site Visit...');
//   //   String fileName = imageFileSite!.path.split('/').last;
//   //   String extension = fileName.split('.').last;
//   //   String addressStr = "";

//   //   print(fileName);
//   //   FormData formData = FormData.fromMap({
//   //     "file": await MultipartFile.fromFile(imageFile!.path, filename: fileName),
//   //     "emp_id": empId,
//   //     "type": "site_visiting",
//   //     "sub_type": subType,
//   //     "site_name": siteName,
//   //     "lat": _currentPositionSite!.latitude.toString(),
//   //     "lng": _currentPositionSite!.longitude.toString(),
//   //     "location": addressStr,
//   //   });
//   //   String apiUrl = baseUrl + "common_api/add-site-visit";
//   //   print(apiUrl);

//   //   Dio dio = Dio();
//   //   dio.options.headers['Content-Type'] = 'multipart/form-data';
//   //   dio.options.headers['X-Auth-Token'] = token;
//   //   try {
//   //     var response = await dio.post(apiUrl, data: formData);
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data['error'] == false) {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.green,
//   //       );
//   //       getSiteDetails();
//   //     } else {
//   //       Toast.show(
//   //         response.data['message'],
//   //         duration: Toast.lengthLong,
//   //         gravity: Toast.bottom,
//   //         backgroundColor: Colors.red,
//   //       );
//   //     }
//   //   } on DioError catch (e) {
//   //     print(e);
//   //     print(e.response.toString());
//   //     Navigator.pop(context);
//   //     Toast.show(
//   //       e.message,
//   //       duration: Toast.lengthLong,
//   //       gravity: Toast.bottom,
//   //       backgroundColor: Colors.red,
//   //     );
//   //   }
//   // }
// }
