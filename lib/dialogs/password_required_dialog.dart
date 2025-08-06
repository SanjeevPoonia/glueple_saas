import 'package:flutter/material.dart';
import 'package:glueplenew/payslip/payslip_download_dialog.dart';
import 'package:glueplenew/pending_scr/add_event_dialog.dart';

class PassRequiredDialog extends StatefulWidget {
  @override
  State<PassRequiredDialog> createState() => _PassRequiredDialog();
}

class _PassRequiredDialog extends State<PassRequiredDialog> {
  TextEditingController passwordCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
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
                      "Password is required",
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
                Text(
                  "This document is password protected. Please enter a password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlue.shade400,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Spacer(),
                        ],
                      ),
                      TextField(
                        controller: passwordCtl,
                        maxLength: 500,
                        obscureText: true,
                        // maxLines: 2,
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                          gradient: LinearGradient(
                            colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => PayslipDownloadDialog(),
                            );
                          },
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
                            "Submit",
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
