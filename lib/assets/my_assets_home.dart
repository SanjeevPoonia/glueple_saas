import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glueplenew/profile/details_saved_dialog.dart';
import 'package:signature/signature.dart';
import '../widget/appbar.dart'; // Assuming this file exists and is correctly implemented

class MyAssetHome extends StatefulWidget {
  const MyAssetHome({super.key});

  @override
  State<MyAssetHome> createState() => _MyAssetHome();
}

class _MyAssetHome extends State<MyAssetHome> {
  int assetRequest = 1;
  int assignedAsset = 2;
  int understakingForm = 1;
  int _selectedAssetCard = 0;
  bool selectedviewall = false;
  int taskSelection = 0; // For tabs within the Assets Request section
  int _selectedStatCard = 0; // New state variable for the main sections
  int selectedassetrequestbutton = 1;
  String? priority = "Please Select";
  String? process = "Please Select";
  String? type = "Please Select";
  final TextEditingController descCtl = TextEditingController();
  List<String> priorityOptions = ["Low", "Medium", "High"];
  List<String> processOptions = ["New", "Replacement"];
  List<String> typeOptions = [
    "Laptop",
    "Mobile",
    "Tablet",
    "RAM",
    "Mouse",
    "Keyboard",
    "Monitor",
    "Printer",
    "Scanner",
    "Projector",
    "Cable",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'My Asset',
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard(
                              0,
                              assetRequest.toString(),
                              "Assets\nRequest",
                            ),
                            _buildStatCard(
                              1,
                              assignedAsset.toString(),
                              "Assigned\nAssets",
                            ),
                            _buildStatCard(
                              2,
                              understakingForm.toString(),
                              "Undertaking\nForm",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: _buildBodyBasedOnSelection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyBasedOnSelection() {
    switch (_selectedStatCard) {
      case 0:
        return _buildAssetsRequestContent();
      case 1:
        return _buildAssignedAssetsContent();
      case 2:
        return _buildUndertakingFormContent();
      default:
        return Container();
    }
  }

  Widget _buildAssetsRequestContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectedassetrequestbutton == 0) {
                selectedassetrequestbutton = 1;
              } else {
                selectedassetrequestbutton = 0;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1B81A4),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1B81A4),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            width: double.maxFinite,
            height: 55,
            child: Center(
              child: Text(
                "Assets Request",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        selectedassetrequestbutton == 0
            ? Column(
                children: [
                  buildProcessField(
                    "Asset Process",
                    process,

                    (val) => setState(() => process = val),
                    AssetProcessDialog(),
                  ),
                  const SizedBox(height: 12),

                  buildProcessField(
                    "Asset Type",
                    type,
                    (val) => setState(() => type = val),
                    AssetTypeDialog(),
                  ),
                  const SizedBox(height: 12),

                  buildProcessField(
                    "Assets Priority",
                    priority,
                    (val) => setState(() => priority = val),
                    PriorityDialog(),
                  ),
                  const SizedBox(height: 12),

                  buildTextField(
                    "Description",
                    descCtl,
                    hint: "Enter description",
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                      color: Color(0xFF00C797),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => AssetRequestDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
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
                  const SizedBox(height: 20),
                ],
              )
            : SizedBox(),

        const Text(
          "Assets Request",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.maxFinite,
          height: 55,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabButton(0, 'Completed'),
              _buildTabButton(1, 'Active'),
              _buildTabButton(2, 'Rejected'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildAssetCard(
          'QD2413',
          'Laptop',
          'New',
          '30 May 2023',
          'High',
          'Assigned by HR',
          'Please assign a Laptop',
        ),
        const SizedBox(height: 16),
        _buildAssetCard(
          'QD2414',
          'Monitor',
          'In Process',
          '31 May 2023',
          'Medium',
          'Pending Approval',
          'A new monitor is required for the user.',
        ),
      ],
    );
  }

  Widget buildProcessField(
    String label,
    String? selectedValue,
    Function(String) onSelected,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => screen,
        );

        if (result != null) {
          onSelected(result);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F7FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Color(0xFF707070)),
                ),
                Text(
                  selectedValue ?? label,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedValue == null ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
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

  Widget _buildAssignedAssetsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Assigned Assets",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAssignedAssetDetailRow(
                'Asset Type',
                'Desktop',
                'Brand',
                'THINKCENTER',
              ),
              const Divider(),
              _buildAssignedAssetDetailRow(
                'Model',
                'LENOVO',
                'Purchase Date',
                '35000',
              ),
              const Divider(),
              _buildAssignedAssetDetailRow(
                'Serial No',
                '1N113602RN',
                'Host Name',
                'QDS-D008-IT',
              ),
              const Divider(),
              _buildAssignedAssetDetailRow(
                'Asset Assigned By',
                'Aabhilash Nagar',
                '',
                '',
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Undertaking Form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUndertakingFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        _selectedAssetCard == 0
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // padding: const EdgeInsets.only(top: 20),
                children: [
                  assetCard(
                    assetNumber: "1",
                    assetType: "Desktop",
                    serialNo: "1N113602RN",
                  ),
                  assetCard(
                    assetNumber: "2",
                    assetType: "HeadPhone",
                    serialNo: "1N113602AB",
                  ),
                  assetCard(
                    assetNumber: "3",
                    assetType: "Phone",
                    serialNo: "2P113602RN",
                  ),
                ],
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      "IT Asset Undertaking Form",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Below is the Acknowledgement of equipment held by\nEmployee of QDegrees Services Pvt. Ltd.",
                      style: TextStyle(fontSize: 15, color: Color(0xFF00C797)),
                    ),
                    const SizedBox(height: 20),

                    // Card with details
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildRow("Employee Joining Date", "24-10-23"),
                          Divider(),
                          _buildRow("Employee ID", "QD2484"),
                          Divider(),
                          _buildRow("Employee Name", "Nikita Prajapat"),
                          Divider(),
                          _buildRow("Department", "Product Development"),
                          Divider(),
                          _buildRow("HOD Name", "Sushant Banga"),
                          Divider(),
                          selectedviewall
                              ? Column(
                                  children: [
                                    _buildRow("Location", "Corporate Office"),
                                    Divider(),
                                    _buildRow(
                                      "Email ID",
                                      "nikita.prajapat@qdegrees.org",
                                    ),
                                    Divider(),
                                    _buildRow(
                                      "Personal Email ID",
                                      "nikita123@gmail.com",
                                    ),
                                    Divider(),
                                    _buildRow("Mobile Number", "9123456789"),
                                    Divider(),
                                    _buildRow("Asset Type", "Desktop"),
                                    Divider(),
                                    _buildRow("Asset Company", "THINKCENTER"),
                                    Divider(),
                                    _buildRow("Model", "Lenovo"),
                                    Divider(),
                                    _buildRow("Serial No.", "1N113602RN"),
                                    Divider(),
                                    _buildRow("Asset Issue Date", "24-10-23"),
                                    Divider(),
                                    _buildRow(
                                      "Asset Issued By",
                                      "Aabhilash Nagar",
                                    ),
                                    Divider(),
                                    _buildRow("Comments", "N/A"),
                                    Divider(),
                                    _buildRow("Undertaking Date", "-"),
                                    Divider(),
                                    _buildRow("IMEI 1/IMEI 2 Number", "-"),
                                    Divider(),
                                    _buildRow(
                                      "Approximate Asset Value",
                                      "35000",
                                    ),
                                    Divider(),
                                  ],
                                )
                              : Container(),

                          // Signature Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Employee's Signature",
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5E5E5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedviewall = !selectedviewall;
                                });
                              },
                              child: Text(
                                selectedviewall ? "View Less" : "View All",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF00C797),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {},
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.blueGrey[800],
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           padding: const EdgeInsets.symmetric(vertical: 14),
                    //         ),
                    //         child: const Text("T&C"),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 12),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {},
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.teal,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           padding: const EdgeInsets.symmetric(vertical: 14),
                    //         ),
                    //         child: const Text("Sign Form"),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 3),
                              ],
                              color: Color(0xFF1B81A4),
                            ),
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => TermsConditionDialog(),
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
                                "T&C",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                ),
                              ],
                              color: Color(0xFF00C797),
                            ),
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => SignFormDialog(),
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
                                "Sign Form",
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
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(int index, String value, String label) {
    final bool isSelected = _selectedStatCard == index;
    final Color selectedTextColor = Colors.white;
    final Color unselectedTextColor = const Color(0xFF1B81A4);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatCard = index;
        });
      },
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(colors: [Color(0xFFEFEEFA), Color(0xFFEFEEFA)]),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.black26 : Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
                height: 1,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? selectedTextColor : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    bool isActive = taskSelection == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          taskSelection = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 123,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1B81A4) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAssetCard(
    String empId,
    String assetType,
    String assetProcess,
    String date,
    String assetPriority,
    String priorityLabel,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildDetailColumn('Emp Id', 'QD2413')),
              Expanded(child: _buildDetailColumn('Asset Type', 'Laptop')),
            ],
          ),
          const Divider(height: 25),
          Row(
            children: [
              Expanded(child: _buildDetailColumn('Asset Process', 'New')),
              Expanded(child: _buildDetailColumn('Date', '30 May 2023')),
            ],
          ),
          const Divider(height: 25),
          _buildPriorityRow('Asset Priority', 'High', 'Assigned by HR'),
          const Divider(height: 25),
          _buildDetailColumn('Asset Description', 'Please assign a Laptop'),
          const Divider(height: 25),
          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ViewDetailsDialog(),
                );
              },
              child: Text(
                "View Details",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF00C797),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget assetCard({
    required String assetNumber,
    required String assetType,
    required String serialNo,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAssetCard = int.parse(assetNumber);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF7F6FD),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Asset $assetNumber",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(6),
                //   decoration: BoxDecoration(
                //     color: const Color(0xFF00AEEF), // Eye container color
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: Image.asset(
                //     "assets/eye_container.png",
                //     color: Colors.white,
                //     width: 40,
                //     height: 20,
                //   ),
                // ),
                Image.asset("assets/eye_container.png", width: 50, height: 25),
              ],
            ),
            const SizedBox(height: 5),
            Divider(),
            const SizedBox(height: 5),

            /// Asset Type & Serial No
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Asset Type",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "Serial No",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  assetType,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                Text(
                  serialNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityRow(String label, String value, String priorityLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  priorityLabel,
                  style: TextStyle(
                    color: Color(0xFFFF0000),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedAssetDetailRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssetRequestDialog extends StatefulWidget {
  const AssetRequestDialog({super.key});

  @override
  State<AssetRequestDialog> createState() => _AssetRequestDialog();
}

class _AssetRequestDialog extends State<AssetRequestDialog> {
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
                  "Asset Request has been submitted successfully",
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

class TermsConditionDialog extends StatefulWidget {
  const TermsConditionDialog({super.key});

  @override
  State<TermsConditionDialog> createState() => _TermsConditionDialog();
}

class _TermsConditionDialog extends State<TermsConditionDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
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
                      "Terms & Condition",
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
                  "I , understand the guidelines and policies for QDegrees Services Pvt. Ltd. equipment use . I will only be using QDegrees assests for business purpose only . Any software or hardware to be installed is required to have prior approval before installation . Upon any termination with QDegrees (whether voluntary/In voluntary) , I will return all above mentioned asset within 48 hours , if failed to do so will pay the penalty equal to asset value mentioned above , else degrees is liable to take legal action against me . In addition , I also acknowledge that I will not receive the last paycheck , unless I return the above mentioned asset . QDegrees retains the right to file for recovery of asset through Court Proceedings .",
                  style: TextStyle(fontSize: 16, color: Color(0xFF7A7A7A)),
                ),
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
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
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

class SignFormDialog extends StatefulWidget {
  const SignFormDialog({super.key});

  @override
  State<SignFormDialog> createState() => _SignFormDialog();
}

class _SignFormDialog extends State<SignFormDialog> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
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
                      "Sign Form",
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

                // Content rows
                _buildRow("Assigned By", "Aniket Sachdeva"),
                const Divider(),
                _buildRow("Handover To", "Vaibhav Saini"),
                const Divider(),

                const SizedBox(height: 10),
                const Text(
                  "Employee's Signature :",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF707070),
                  ),
                ),
                const SizedBox(height: 8),

                // Signature pad
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE5E5E5)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.grey.shade200,
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
                            BoxShadow(color: Colors.black26, blurRadius: 3),
                          ],
                          color: Color(0xFF1B81A4),
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
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                          color: Color(0xFF00C797),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _signatureController.clear();
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
                            "Clear",
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

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class AssetProcessDialog extends StatelessWidget {
  const AssetProcessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.34,
        minChildSize: 0.34,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Select Asset Process",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "New"),
                  child: const Text(
                    "New",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Replacement"),
                  child: const Text(
                    "Replacement",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssetTypeDialog extends StatelessWidget {
  const AssetTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.8,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Select Asset Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "Laptop"),
                  child: const Text(
                    "Laptop",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Mobile"),
                  child: const Text(
                    "Mobile",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Tablet"),
                  child: const Text(
                    "Tablet",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "RAM"),
                  child: const Text(
                    "RAM",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Mouse"),
                  child: const Text(
                    "Mouse",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Keyboard"),
                  child: const Text(
                    "Keyboard",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Monitor"),
                  child: const Text(
                    "Monitor",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Printer"),
                  child: const Text(
                    "Printer",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Scanner"),
                  child: const Text(
                    "Scanner",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Projector"),
                  child: const Text(
                    "Projector",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Cable"),
                  child: const Text(
                    "Cable",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Others"),
                  child: const Text(
                    "Others",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriorityDialog extends StatelessWidget {
  const PriorityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.34,
        minChildSize: 0.34,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Select Asset Priority",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),

                // Options
                TextButton(
                  onPressed: () => Navigator.pop(context, "Low"),
                  child: const Text(
                    "Low",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "Medium"),
                  child: const Text(
                    "Medium",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, "High"),
                  child: const Text(
                    "High",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewDetailsDialog extends StatefulWidget {
  @override
  State<ViewDetailsDialog> createState() => _ViewDetailsDialog();
}

class _ViewDetailsDialog extends State<ViewDetailsDialog> {
  DateTime selectedDate = DateTime.now();
  TextEditingController createdAtCtl = TextEditingController(
    text: "Please Assign a Laptop",
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
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
                      "View Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
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
                // Attendance Date Container
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emp ID",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "QD2484",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "nikita.prajapati@qdegrees.org",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Asset Type",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Laptop",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Priority",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Normal",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Created at",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        selectedDate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

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
                            "Created at",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      TextField(
                        controller: createdAtCtl,
                        maxLength: 500,
                        maxLines: 2,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            "Close",
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
