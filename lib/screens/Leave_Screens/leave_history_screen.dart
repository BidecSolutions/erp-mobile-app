import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_app/utils/app_layout.dart';
import 'package:flutter_app/utils/show_modal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  String? selectedLeaveType;
  String? selectedStatus;
  String? selectedDateRange;

  final List<String> leaveTypes = [
    'Sick Leave',
    'Casual Leave',
    'Earned Leave',
  ];

  final List<String> statusOptions = ['Pending', 'Approved', 'Rejected'];

  final List<String> dateRanges = ['This Month', 'Last Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔙 Header with Back + Title + More Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppNavigator.goToScreen(1); // 👈 Back to Leave Screen
                    },
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  Text(
                    'View History',
                    style: TextStyle(
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.more_vert, size: 24),
                ],
              ),

              SizedBox(height: height * 0.03),

              /// 🔍 Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.black54),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              /// 🧩 Filter Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _filterChip(context, "Leave Type"),
                  _filterChip(context, "Status"),
                  _filterChip(context, "Date Range"),
                ],
              ),

              SizedBox(height: height * 0.02),

              /// 📋 Leave List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final isApproved = index % 2 == 0;
                    return _leaveCard(context, isApproved);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔘 Reusable Filter Chip
  /// 🔘 Interactive Filter Chip (Dropdown enabled)
  Widget _filterChip(BuildContext context, String title) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    List<String> options = [];
    String? selectedValue;

    // Determine which dropdown it is
    if (title == "Leave Type") {
      options = leaveTypes;
      selectedValue = selectedLeaveType;
    } else if (title == "Status") {
      options = statusOptions;
      selectedValue = selectedStatus;
    } else if (title == "Date Range") {
      options = dateRanges;
      selectedValue = selectedDateRange;
    }

    return Container(
      width: width * 0.27,
      margin: EdgeInsets.only(right: 2.w),
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 1.h,
      ), // 👈 reduce padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18), // 👈 slightly smaller radius
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true, // 👈 important for smaller height
          menuMaxHeight: 200, // optional: limit dropdown menu height
          iconSize: 18, // 👈 smaller arrow icon
          isExpanded: true,
          hint: Text(
            title,
            style: TextStyle(
              fontSize: height * 0.014,
              color: Colors.black,
            ), // 👈 smaller font
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
          value: selectedValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: height * 0.012,
                  color: Colors.black,
                ), // 👈 smaller text
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              if (title == "Leave Type") {
                selectedLeaveType = newValue;
              } else if (title == "Status") {
                selectedStatus = newValue;
              } else if (title == "Date Range") {
                selectedDateRange = newValue;
              }
            });
          },
        ),
      ),
    );
  }

  /// 🧾 Leave Summary Card
  Widget _leaveCard(BuildContext context, bool isApproved) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: height * 0.015),
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                  Expanded(
                    flex: 2,
                    child: _infoColumn("Leave type", "Medical Leave"),
                  ),
                  Expanded(child: _infoColumn("No of Day", "2")),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isApproved ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isApproved ? "Approved" : "Pending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25),

                  /// Give space for the arrow but DO NOT move UI
                ],
              ),
              SizedBox(height: height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn("Leave Date", "05 May 2025 - 07 May 2025"),
                  _infoColumn("Applied on", "04 May 2024"),
                ],
              ),
            ],
          ),
        ),

        /// ✅ Clickable Floating Arrow (exact same visual position)
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () {
              showCustomModal(
                context: context,
                title: "Leave Details",
                content: _leaveDetailContent({
                  "type": "Medical Leave",
                  "days": "2",
                  "status": isApproved ? "Approved" : "Pending",
                  "leaveDate": "05 May 2025 - 07 May 2025",
                  "appliedOn": "04 May 2025",
                  "reason": "Fever and cold",
                  "attachmentUrl": "https://via.placeholder.com/150",
                }),
              );
            },
            child: const Icon(Icons.arrow_outward_rounded, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _leaveDetailContent(Map<String, dynamic> leave) {
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'approved':
          return Colors.green.shade400;
        case 'rejected':
          return Colors.orange.shade400;
        case 'pending':
        default:
          return Colors.red.shade400;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // top row with leave type & no. of days
        _infoRow(
          "Leave type",
          leave["type"] ?? "N/A",
          "No of Day",
          leave["days"] ?? "N/A",
        ),
        const SizedBox(height: 8),

        // applied on & status (with colored badge)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _labelValue("Applied on", leave["appliedOn"] ?? "N/A"),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelText("Status"),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor(leave["status"] ?? "Pending"),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      leave["status"] ?? "Pending",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        _labelText("Leave Date"),
        Text(leave["leaveDate"] ?? "N/A", style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        _labelText("Reason for Leave"),
        Text(
          leave["reason"] ?? "No reason provided",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
        _labelText("Attachment"),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:
              leave["attachmentUrl"] != null &&
                  leave["attachmentUrl"].isNotEmpty
              ? Image.network(
                  leave["attachmentUrl"],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                )
              : Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _infoRow(String label1, String value1, String label2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _labelValue(label1, value1)),
        Expanded(child: _labelValue(label2, value2)),
      ],
    );
  }

  Widget _labelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelText(label),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _labelText(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey, fontSize: 13));
  }

  /// 🏷 Reusable Info Column
  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
