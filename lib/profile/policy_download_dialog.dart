// - We at QDegrees believe to operate our business in the most ethical and professional way and expect our employees to-
// - Deal on behalf of the Company with professionalism, honesty, integrity as well as high moral and ethical standards.
// - Never compromise our values, no matter how strong the internal or external pressure may be to perform, meet goals.
// - Be a role modelby communicating with others and acting in a manner consistent withour core values.
// - Adhere, adopt and follow the practices in business ethics. Many of these practices attract legal requirements.
// - Violation of laws can cause significant damage to an individual or the company thus an employee should seriously carry accountability and comply.v

import 'package:flutter/material.dart';

class PolicyDownloadDialog extends StatefulWidget {
  @override
  State<PolicyDownloadDialog> createState() => _PolicyDownloadDialog();
}

class _PolicyDownloadDialog extends State<PolicyDownloadDialog> {
  TextEditingController passwordCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
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
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 8),
                Text(
                  '''
- We at QDegrees believe to operate our business in the most ethical and professional way and expect our employees to-
- Deal on behalf of the Company with professionalism, honesty, integrity as well as high moral and ethical standards.
- Never compromise our values, no matter how strong the internal or external pressure may be to perform, meet goals.
- Be a role modelby communicating with others and acting in a manner consistent withour core values.
- Adhere, adopt and follow the practices in business ethics. Many of these practices attract legal requirements.
- Violation of laws can cause significant damage to an individual or the company thus an employee should seriously carry accountability and comply.v''',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Text(
                  "I have thoroughly read the instructions and accepted the policy",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlue.shade400,
                  ),
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          color: Colors.grey.shade300,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
                            "Back",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
