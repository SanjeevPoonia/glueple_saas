import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/appbar.dart';

class PolicyDetailScreen extends StatefulWidget {
  final String baseUrl;
  final String token;
  final String clientCode;

  const PolicyDetailScreen({
    super.key,
    required this.baseUrl,
    required this.token,
    required this.clientCode,
  });

  @override
  State<PolicyDetailScreen> createState() => _PolicyDetailScreenState();
}

class _PolicyDetailScreenState extends State<PolicyDetailScreen> {
  bool isLoading = true;
  List<dynamic> policyList = [];

  @override
  void initState() {
    super.initState();
    getPolicyList();
  }

  Future<void> getPolicyList() async {
    ApiBaseHelper helper = ApiBaseHelper();
    try {
      var response = await helper.getWithToken(
        widget.baseUrl,
        'get-policy-list',
        widget.token,
        widget.clientCode,
        context,
      );

      var responseJSON = json.decode(response.body);
      print("Policy List Response: $responseJSON");

      if (responseJSON['code'] == 200 && responseJSON['data'] != null) {
        setState(() {
          policyList = responseJSON['data'];
          isLoading = false;
        });
      } else {
        Toast.show(
          responseJSON['message'] ?? "Something went wrong",
          gravity: Toast.bottom,
          duration: Toast.lengthLong,
          backgroundColor: Colors.red,
        );
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching policy list: $e");
      Toast.show(
        "Network error occurred",
        gravity: Toast.bottom,
        duration: Toast.lengthLong,
        backgroundColor: Colors.red,
      );
      setState(() => isLoading = false);
    }
  }

  Future<void> _openPdf(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      Toast.show(
        "Could not open PDF",
        gravity: Toast.bottom,
        duration: Toast.lengthLong,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Policy Details',
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
            onPressed: () {},
          ),
          const IconButton(
            icon: Icon(Icons.category, size: 30, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundGlow(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),

                        Text(
                          "Policy",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // padding: const EdgeInsets.all(16),
                                  itemCount: policyList.length,
                                  itemBuilder: (context, index) {
                                    final policy = policyList[index];
                                    return Column(
                                      children: [
                                        _buildRow(
                                          policy['title'] ?? 'Untitled',
                                          () {
                                            if (policy['file'] != null) {
                                              _openPdf(policy['file']);
                                            }
                                          },
                                        ),
                                        if (index != policyList.length - 1)
                                          const Divider(),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, VoidCallback onDownload) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
        GestureDetector(
          onTap: onDownload,
          child: const Icon(
            Icons.downloading_outlined,
            size: 22,
            color: Color(0xFF00C797),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundGlow() {
    return IgnorePointer(
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
    );
  }
}
