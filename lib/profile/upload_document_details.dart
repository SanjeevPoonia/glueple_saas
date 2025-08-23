import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:glueplenew/widget/appbar.dart';

class EditDocumentUploadDetails extends StatefulWidget {
  final dynamic profiledata;
  final String token;
  final String baseUrl;
  const EditDocumentUploadDetails({
    required this.profiledata,
    required this.token,
    required this.baseUrl,
    super.key,
  });

  @override
  State<EditDocumentUploadDetails> createState() =>
      _EditDocumentUploadDetails();
}

class _EditDocumentUploadDetails extends State<EditDocumentUploadDetails> {
  var profiledata;
  String? panCardFileName;
  String? aadharFrontFileName;
  String? aadharBackFileName;
  String? passportFrontFileName;
  String? passportBackFileName;
  String? drivingLicense;
  String? resume;
  String? passportSizePhoto;
  Future<void> filepicker(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      setState(() {
        if (type == 'pan') {
          panCardFileName = fileName;
        } else if (type == 'aadharFront') {
          aadharFrontFileName = fileName;
        } else if (type == 'aadharBack') {
          aadharBackFileName = fileName;
        } else if (type == 'passportFront') {
          passportFrontFileName = fileName;
        } else if (type == 'passportBack') {
          passportBackFileName = fileName;
        } else if (type == 'drivingLicense') {
          drivingLicense = fileName;
        } else if (type == 'resume') {
          resume = fileName;
        } else if (type == 'passportSizePhoto') {
          passportSizePhoto = fileName;
        }
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // White background
      appBar: CustomAppBar(
        title: 'Edit Profile Details',
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
          // Fixed glowing background
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    "Upload Documents",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Aadhar",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: aadharFrontFileName != null
                                    ? Text(
                                        aadharFrontFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload Aadhar Front',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('aadharFront'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('aadharFront'),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: aadharBackFileName != null
                                    ? Text(
                                        aadharBackFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upload Aadhar Back',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('aadharBack'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('aadharBack'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Passport",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: passportFrontFileName != null
                                    ? Text(
                                        passportFrontFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Passport Front',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('passportFront'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('passportFront'),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: passportBackFileName != null
                                    ? Text(
                                        passportBackFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Passport Back',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('passportBack'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('passportBack'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Pan Card",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: panCardFileName != null
                                    ? Text(
                                        panCardFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pan Card',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('pan'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('pan'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Driving License",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: drivingLicense != null
                                    ? Text(
                                        drivingLicense!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Driving License',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () => filepicker(
                                                  'drivingLicense',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('pan'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Resume",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: panCardFileName != null
                                    ? Text(
                                        panCardFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Resume',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    filepicker('resume'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () => filepicker('resume'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Upload Passport Size Photo",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                                child: panCardFileName != null
                                    ? Text(
                                        panCardFileName!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Passport Size Photo',
                                            style: TextStyle(
                                              color: Color(0xFF1B81A4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Choose File',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Transform.rotate(
                                                  angle:
                                                      -0.785398, // -45 degrees in radians
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () => filepicker(
                                                  'passportSizePhoto',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.cloud_upload,
                                  color: Color(0xFF00C797),
                                ),
                                onPressed: () =>
                                    filepicker('passportSizePhoto'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),

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
                                builder: (context) => EditSavedDialog(),
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
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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
}
