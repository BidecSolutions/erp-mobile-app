import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_app/utils/show_modal.dart';
import '../../utils/app_layout.dart'; // adjust path if your AppLayout file is elsewhere

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- App Bar ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppNavigator.goToScreen(
                        0,
                      ); // 👈 Go back to LeaveScreen (index 1)
                    },
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  Text(
                    'Leave',
                    style: TextStyle(
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.more_vert, size: 24),
                ],
              ),
              SizedBox(height: height * 0.03),

              // ---------- Top Leave Menu ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopMenu(
                    context,
                    icon: Icons.logout, // placeholder icon
                    title: 'Leave\nApplication',
                    onTap: () {
                      AppNavigator.goToScreen(2); // show leave form
                    },
                  ),
                  _buildTopMenu(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Planned\nLeave',
                  ),
                  _buildTopMenu(
                    context,
                    icon: Icons.sync,
                    title: 'Leave\nReversal',
                    onTap: () {
                      AppNavigator.goToScreen(6);
                    },
                  ),
                ],
              ),

              SizedBox(height: height * 0.03),
              Divider(thickness: 1, color: Colors.black.withValues(alpha: 0.2)),

              // ---------- Total Leaves ----------
              SizedBox(height: height * 0.02),
              Center(
                child: Text(
                  'Total Leaves : 24',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.022,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              Center(
                child: Text(
                  'Causal leave : 10   Sick Leave : 14   Annual Leave : 24',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height * 0.015,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),
              // ---------- Pending Leaves ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pending Leaves',
                    style: TextStyle(
                      fontSize: height * 0.022,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.goToScreen(
                        3,
                      ); // 👈 navigate to LeaveHistoryScreen (index 3 in MainLayout)
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.006,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'View Detail',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.015),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.015,
                  horizontal: width * 0.04,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Casual Leave - 5   |   Sick Leave - 3   |   Annual Leave - 10',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: height * 0.03),
              Text(
                'Leave Summary',
                style: TextStyle(
                  fontSize: height * 0.022,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.015),

              // ---------- Leave Cards ----------
              _buildLeaveCard(context),
              _buildLeaveCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Top Menu Item ----------
  Widget _buildTopMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool selected = false,
    VoidCallback? onTap, // 👈 add this line
  }) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return GestureDetector(
      onTap: onTap, // 👈 make it tappable
      child: Container(
        width: width * 0.26,
        padding: EdgeInsets.all(height * 0.018),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF222A44) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: height * 0.035,
              color: selected ? Colors.white : Colors.black,
            ),
            SizedBox(height: height * 0.01),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height * 0.017,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Leave Summary Card ----------
  Widget _buildLeaveCard(BuildContext context) {
    final height = AppLayout.getDeviceHeight(context);
    final width = AppLayout.getDeviceWidth(context);

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildColumnText('Leave type', 'Medical Leave', height),
                  _buildColumnText('No of Day', '2', height),
                  _buildStatusBadge('Pending'),
                ],
              ),
              SizedBox(height: height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildColumnText(
                    'Leave Date',
                    '05 May 2025 - 07 May 2025',
                    height,
                  ),
                  _buildColumnText('Applied on', '04 May 2024', height),
                ],
              ),
            ],
          ),

          // ✅ Floating clickable arrow
          Positioned(
            right: -5,
            top: -10,
            child: GestureDetector(
              onTap: () {
                showCustomModal(
                  context: context,
                  title: "Leave Details",
                  content: _leaveDetailContent({
                    "type": "Medical Leave",
                    "days": "2",
                    "status": "Pending",
                    "leaveDate": "05 May 2025 - 07 May 2025",
                    "appliedOn": "04 May 2025",
                    "reason": "Fever and cold",
                    "attachmentUrl": "https://via.placeholder.com/150",
                  }),
                );
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(Icons.arrow_outward_rounded, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnText(String label, String value, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: height * 0.017),
        ),
        SizedBox(height: height * 0.004),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: height * 0.018,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
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
}
