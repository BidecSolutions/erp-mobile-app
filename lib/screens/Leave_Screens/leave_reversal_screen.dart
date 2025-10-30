import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_app/utils/app_layout.dart';
import 'package:flutter_app/utils/show_modal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveReversalScreen extends StatefulWidget {
  const LeaveReversalScreen({super.key});

  @override
  State<LeaveReversalScreen> createState() => _LeaveReversalScreenState();
}

class _LeaveReversalScreenState extends State<LeaveReversalScreen> {
  final List<Map<String, dynamic>> requestReversalLeaves = [
    {
      "type": "Medical Leave",
      "days": "2",
      "status": "Pending",
      "leaveDate": "05 May 2025 - 07 May 2025",
      "appliedOn": "04 May 2024",
    },
  ];

  final List<Map<String, dynamic>> approvedLeaves = [
    {
      "type": "Medical Leave",
      "days": "2",
      "status": "Approved",
      "leaveDate": "05 May 2025 - 07 May 2025",
      "appliedOn": "04 May 2024",
    },
    {
      "type": "Medical Leave",
      "days": "2",
      "status": "Approved",
      "leaveDate": "05 May 2025 - 07 May 2025",
      "appliedOn": "04 May 2024",
    },
    {
      "type": "Medical Leave",
      "days": "2",
      "status": "Approved",
      "leaveDate": "05 May 2025 - 07 May 2025",
      "appliedOn": "04 May 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔙 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => AppNavigator.goToScreen(1),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  Text(
                    'Leave Reversal',
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

              /// 🧩 Section 1 — Request Reversal Leaves
              Text(
                "Request Reversal Leaves",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),

              if (requestReversalLeaves.isEmpty)
                Text(
                  "No pending reversals",
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                )
              else
                ...requestReversalLeaves
                    .map((leave) => _leaveCard(context, leave))
                    .toList(),

              Divider(color: Colors.grey.shade300, height: 30.h),

              /// 🧩 Section 2 — Approved Leaves
              Text(
                "Approved Leaves",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),

              if (approvedLeaves.isEmpty)
                Center(
                  child: Text(
                    "No approved leaves",
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                )
              else
                ...approvedLeaves
                    .map((leave) => _leaveCard(context, leave))
                    .toList(),
            ],
          ),
        ),
      ),
    );
  }

  /// 🧾 Leave Card
  Widget _leaveCard(BuildContext context, Map<String, dynamic> leave) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);
    final isApproved = leave["status"] == "Approved";

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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row: Type + Days + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: _infoColumn("Leave type", leave["type"]),
                  ),
                  Expanded(child: _infoColumn("No of Day", leave["days"])),
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
                            leave["status"],
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

                  /// reserve tiny space so row doesn’t shift
                  SizedBox(width: 25),
                ],
              ),

              SizedBox(height: height * 0.015),

              /// Dates Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn("Leave Date", leave["leaveDate"]),
                  _infoColumn("Applied on", leave["appliedOn"]),
                ],
              ),
            ],
          ),
        ),

        /// ✅ Floating tappable arrow — exact same position visually
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () {
              showCustomModal(
                context: context,
                title: "Leave Details",
                content: _leaveDetailContent(leave),
              );
            },
            child: const Icon(Icons.arrow_outward_rounded, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _leaveDetailContent(Map<String, dynamic> leave) {
    Color _getStatusColor(String status) {
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
                      color: _getStatusColor(leave["status"] ?? "Pending"),
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
