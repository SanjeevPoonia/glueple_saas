import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glueplenew/network/api_helper.dart';

class ProfilePhotoDialog extends StatefulWidget {
  final String token;
  final String baseUrl;
  final Function(String) onPhotoUploaded; // callback to update parent

  const ProfilePhotoDialog({
    super.key,
    required this.token,
    required this.baseUrl,
    required this.onPhotoUploaded,
  });

  @override
  State<ProfilePhotoDialog> createState() => _ProfilePhotoDialog();
}

class _ProfilePhotoDialog extends State<ProfilePhotoDialog> {
  XFile? imageFile;
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
      await uploadProfilePicture();
    }
  }

  Future<void> uploadProfilePicture() async {
    if (imageFile == null) return;

    setState(() => isLoading = true);

    ApiBaseHelper helper = ApiBaseHelper();

    var apiParams = {
      "profile_picture": base64Encode(await imageFile!.readAsBytes()),
    };

    try {
      var rawResponse = await helper.postAPIWithHeader(
        widget.baseUrl,
        'upload-profile',
        apiParams,
        context,
        widget.token,
      );

      var response = jsonDecode(rawResponse.body);

      if (response['success'] == true) {
        String newImage = response['data']['profile_picture'] ?? "";
        widget.onPhotoUploaded(newImage);
        Navigator.of(context).pop();
      } else {
        debugPrint("Upload failed: ${response['errorMessage']}");
      }
    } catch (e) {
      debugPrint("Error uploading profile picture: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.34,
        minChildSize: 0.34,
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Profile Photo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(),
                const SizedBox(height: 8),

                TextButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text(
                    "Upload New Photo",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onPhotoUploaded(""); // remove
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Remove Photo",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                const SizedBox(height: 20),

                if (isLoading) const Center(child: CircularProgressIndicator()),
                SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
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
                      Navigator.of(context).pop();
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
                      "Done",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
