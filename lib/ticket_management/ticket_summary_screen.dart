import 'package:flutter/material.dart';
import 'package:glueplenew/widget/appbar.dart';

class TicketSummaryScreen extends StatefulWidget {
  const TicketSummaryScreen({super.key});

  @override
  State<TicketSummaryScreen> createState() => _TicketSummaryScreen();
}

class _TicketSummaryScreen extends State<TicketSummaryScreen> {
  final TextEditingController ticketgeneratedby = TextEditingController(
    text: "Nikita Prajapat",
  );
  final TextEditingController issuetype = TextEditingController(
    text: "Email Related",
  );
  final TextEditingController issuesubtype = TextEditingController(
    text: "Email Configuration related",
  );
  final TextEditingController issuesubject = TextEditingController(
    text: "Password Reset",
  );
  final TextEditingController numberofimpactedperson = TextEditingController(
    text: "1",
  );
  final TextEditingController messageCtl = TextEditingController(
    text: "Email Password reset done, now OK",
  );

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    // String? hint,
    int? maxLength,
    bool? ismessage = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              if (maxLength != null)
                Text(
                  "${controller.text.length}/$maxLength",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          TextField(
            maxLines: label == "Description" ? 4 : 1,
            controller: controller,
            maxLength: maxLength,
            style: TextStyle(
              fontWeight: ismessage == true ? FontWeight.w600 : FontWeight.w400,
              color: ismessage == true
                  ? Colors.red
                  : Colors.black, // 🔴 change here
            ),
            decoration: InputDecoration(
              // hintText: hint,
              border: InputBorder.none,
              isDense: true,
              counterText: "",
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Ticket Management System',
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
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

          // Scrollable content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  // Text(
                  //   "Family Details",
                  //   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  // ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color: Color(0xFF1B81A4),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => TicketReopenedDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Re-open Ticket",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  buildTextField(
                    "Ticket Generated By:",
                    ticketgeneratedby,
                    // hint: "Enter Father's Name",
                  ),
                  const SizedBox(height: 12),
                  buildTextField("Issue Type", issuetype),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Issue Sub Type",
                    issuesubtype,
                    // hint: "Enter Issue Sub Type",
                  ),
                  const SizedBox(height: 12),
                  buildTextField("Issue Subject:", issuesubject),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Number of Impacted Person:",
                    numberofimpactedperson,
                    // hint: "Enter Spouse Name",
                  ),
                  const SizedBox(height: 12),
                  buildTextField(
                    "Message",
                    messageCtl,
                    ismessage: true,
                    // hint: "Enter First Child's Name",
                  ),

                  const SizedBox(height: 21),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      width: 400,
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
                            vertical: 12,
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
            ),
          ),
        ],
      ),
    );
  }
}

class TicketReopenedDialog extends StatefulWidget {
  const TicketReopenedDialog({super.key});

  @override
  State<TicketReopenedDialog> createState() => _TicketReopenedDialog();
}

class _TicketReopenedDialog extends State<TicketReopenedDialog> {
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
                  "Ticket Reopened\nSuccessfully",
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
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                          gradient: LinearGradient(
                            colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                          ),
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
                            "Next",
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
