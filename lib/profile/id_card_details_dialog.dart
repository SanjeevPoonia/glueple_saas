import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glueplenew/utils/app_theme.dart';

class IDCardDetailsDialog extends StatefulWidget {
  @override
  State<IDCardDetailsDialog> createState() => _IDCardDetailsDialog();
}

class _IDCardDetailsDialog extends State<IDCardDetailsDialog> {
  TextEditingController passwordCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.9,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Spacer(),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Accountability of an employee",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.zero,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Image.asset(
                            "assets/qd_logo.png",
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(width: 10),
                          Spacer(),
                          SvgPicture.asset("assets/idcard_top.svg"),
                          SizedBox(width: 5),
                        ],
                      ),
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://randomuser.me/api/portraits/women/75.jpg",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Nikita Prajapat",
                        style: TextStyle(
                          fontSize: 20.5,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.idCardBlue,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Employee ID",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ":QD2484",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Blood Group",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ":B+",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Emergancy No.",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ":9012345678",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Contact No.",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ":8912345678",
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.idCardBlue,
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          SvgPicture.asset("assets/idcard_btm.svg"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 3),
                          ],
                          color: Colors.grey.shade300,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                          color: Color(0xFF1B81A4),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
