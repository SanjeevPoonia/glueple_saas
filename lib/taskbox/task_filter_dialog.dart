import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glueplenew/network/api_helper.dart';
import 'package:toast/toast.dart';

class TaskFilterBottomSheet extends StatefulWidget {
  final String token;
  final String baseUrl;
  final String clientCode;
  final Function(Map<String, dynamic>) onApplyFilters;

  const TaskFilterBottomSheet({
    super.key,
    required this.token,
    required this.baseUrl,
    required this.clientCode,
    required this.onApplyFilters,
  });

  @override
  State<TaskFilterBottomSheet> createState() => _TaskFilterBottomSheetState();
}

class _TaskFilterBottomSheetState extends State<TaskFilterBottomSheet> {
  int selectedFilterIndex = 0;
  final List<String> filters = ["Employee ID", "Status", "Project"];
  bool selectAll = false;
  List<bool> isChecked = [];
  List<Map<String, String>> currentList = [];

  List<String> selectedEmployees = [];
  List<String> selectedStatuses = [];
  List<String> selectedProjects = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchFilterData();
  }

  Future<void> fetchFilterData() async {
    setState(() {
      isLoading = true;
      currentList = [];
      isChecked = [];
      selectAll = false;
    });

    String endpoint = '';
    if (selectedFilterIndex == 0) {
      endpoint = 'get-all-employee';
    } else if (selectedFilterIndex == 1) {
      endpoint = 'get-dropdown-data';
    } else if (selectedFilterIndex == 2) {
      endpoint = 'get-all-task-project';
    }

    ApiBaseHelper helper = ApiBaseHelper();
    try {
      var response = await helper.getWithToken(
        widget.baseUrl,
        endpoint,
        widget.token,
        widget.clientCode,
        context,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var responseJSON = json.decode(response.body);
      print("Filter Response: $responseJSON");

      if (responseJSON['code'] == 200 && responseJSON['data'] != null) {
        List<Map<String, String>> list = [];

        if (selectedFilterIndex == 0) {
          for (var e in responseJSON['data'] as List) {
            list.add({
              "name": e['name']?.toString() ?? '',
              "id": e['emp_code']?.toString() ?? '',
            });
          }
        } else if (selectedFilterIndex == 1) {
          if (responseJSON['data']['data'] != null) {
            List<dynamic> statusCategories =
                responseJSON['data']['data'] as List;

            var taskStatusCategory;
            for (var category in statusCategories) {
              if (category['category_short_name'] == 'task_status') {
                taskStatusCategory = category;
                break;
              }
            }

            if (taskStatusCategory != null &&
                taskStatusCategory['dropdown_master_details'] != null) {
              for (var e
                  in taskStatusCategory['dropdown_master_details'] as List) {
                list.add({
                  "name": e['label']?.toString() ?? '',
                  "id": e['value']?.toString() ?? '',
                });
              }
            } else {
              print("Task Status category not found or no dropdown details");
              for (var category in statusCategories) {
                if (category['dropdown_master_details'] != null) {
                  for (var e in category['dropdown_master_details'] as List) {
                    list.add({
                      "name": e['label']?.toString() ?? '',
                      "id": e['value']?.toString() ?? '',
                    });
                  }
                  break;
                }
              }
            }
          }
        } else if (selectedFilterIndex == 2) {
          for (var e in responseJSON['data'] as List) {
            list.add({
              "name": e['name']?.toString() ?? '',
              "id": e['_id']?.toString() ?? '',
            });
          }
        }

        setState(() {
          currentList = list;
          isChecked = List.filled(currentList.length, false);
          isLoading = false;
        });
      } else {
        Toast.show(
          responseJSON['message'] ?? "Failed to load filter data",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Filter Error: $e");
      Toast.show(
        "Network error occurred while loading filters",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      isChecked = List.filled(currentList.length, selectAll);
    });
  }

  void toggleSingleSelect(int index, bool? value) {
    setState(() {
      isChecked[index] = value ?? false;
      selectAll = isChecked.every((e) => e);
    });
  }

  void applyFilters() {
    if (selectedFilterIndex == 0) {
      selectedEmployees = currentList
          .asMap()
          .entries
          .where((e) => isChecked[e.key])
          .map((e) => e.value['id']!)
          .toList();
    } else if (selectedFilterIndex == 1) {
      selectedStatuses = currentList
          .asMap()
          .entries
          .where((e) => isChecked[e.key])
          .map((e) => e.value['id']!)
          .toList();
    } else if (selectedFilterIndex == 2) {
      selectedProjects = currentList
          .asMap()
          .entries
          .where((e) => isChecked[e.key])
          .map((e) => e.value['id']!)
          .toList();
    }

    widget.onApplyFilters({
      "employees": selectedEmployees,
      "statuses": selectedStatuses,
      "projects": selectedProjects,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 100,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.grey,
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
                    "Filter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const Divider(),

              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      child: Column(
                        children: List.generate(filters.length, (index) {
                          final isSelected = selectedFilterIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedFilterIndex = index;
                                });
                                fetchFilterData();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? const Color(0xFF007398)
                                    : Colors.grey[300],
                                foregroundColor: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fixedSize: const Size(120, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                filters[index],
                                style: const TextStyle(fontSize: 12.5),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : currentList.isEmpty
                            ? const Center(
                                child: Text(
                                  "No data available",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView(
                                controller: scrollController,
                                children: [
                                  CheckboxListTile(
                                    title: const Text(
                                      "Select all",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    value: selectAll,
                                    onChanged: toggleSelectAll,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                  ...List.generate(currentList.length, (index) {
                                    final item = currentList[index];
                                    return CheckboxListTile(
                                      title: Text(
                                        "${item["name"]} (${item["id"]})",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      value: isChecked[index],
                                      onChanged: (value) =>
                                          toggleSingleSelect(index, value),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    );
                                  }),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C797), Color(0xFF1B81A4)],
                  ),
                ),
                child: TextButton(
                  onPressed: applyFilters,
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
