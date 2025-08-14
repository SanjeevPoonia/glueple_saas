import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMoreExpDialog extends StatefulWidget {
  @override
  State<AddMoreExpDialog> createState() => _AddMoreExpDialog();
}

class _AddMoreExpDialog extends State<AddMoreExpDialog> {
  final TextEditingController orgNameCtl = TextEditingController();
  final TextEditingController desgCtl = TextEditingController();
  final TextEditingController fromCtl = TextEditingController();
  final TextEditingController toCtl = TextEditingController();
  final TextEditingController reasonCtl = TextEditingController();

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('MM/dd/yy').format(picked);
    }
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    int? maxLength,
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
            decoration: InputDecoration(
              hintText: hint,
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

  Widget buildDateField(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _pickDate(controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F7FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                enabled: false,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                  hintText: "mm/dd/yy",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const Icon(Icons.calendar_month, size: 18, color: Colors.black),
          ],
        ),
      ),
    );
  }

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
                      "Add more documents",
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
                  "Add another experience",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                ),
                const SizedBox(height: 12),
                buildTextField("Organisation Name", orgNameCtl, hint: "-"),
                const SizedBox(height: 12),
                buildTextField("Designation", desgCtl, hint: "-"),
                const SizedBox(height: 12),
                buildDateField("From", fromCtl),
                const SizedBox(height: 12),
                buildDateField("To", toCtl),
                const SizedBox(height: 12),
                buildTextField("Reason Of Leaving", reasonCtl, hint: "-"),
                SizedBox(height: 16),

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
                            "Add",
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
