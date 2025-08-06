import 'package:flutter/material.dart';
import 'package:glueplenew/payslip/payslip_preview.dart';

class PayslipDownloadDialog extends StatefulWidget {
  @override
  State<PayslipDownloadDialog> createState() => _PayslipDownloadDialog();
}

class _PayslipDownloadDialog extends State<PayslipDownloadDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.51,
        minChildSize: 0.5,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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

                Image.asset(
                  'assets/run_with_time.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 18),
                Text(
                  "Pay slip Request Downloaded\nsuccessfully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),

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
                            "Back",
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
                          gradient: LinearGradient(
                            colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PayslipPreviewScr();
                                },
                              ),
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
                            "Preview",
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
