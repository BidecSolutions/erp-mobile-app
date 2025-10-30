import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({super.key});
  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  String? selectedLeave = 'Causal Leave';
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool isHalfDay = true;

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7F8FA),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            AppNavigator.goToScreen(1); // Go back to LeaveScreen
          },
        ),
        title: Text(
          'Leave Application',
          style: TextStyle(
            fontSize: height * 0.022,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leave Code Dropdown
            Text('Leave Code', style: _labelStyle()),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: _inputDecoration(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true, // 👈 VERY IMPORTANT
                    value: selectedLeave,
                    items: ['Causal Leave', 'Sick Leave', 'Earned Leave']
                        .map(
                          (leave) => DropdownMenuItem(
                            value: leave,
                            child: Text(
                              leave,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => selectedLeave = value),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // From Date
            Text('From date', style: _labelStyle()),
            SizedBox(height: 8.h),
            _dateField(fromDate, () => _pickDate(context, true)),
            SizedBox(height: 16.h),

            // To Date
            Text('To date', style: _labelStyle()),
            SizedBox(height: 8.h),
            _dateField(toDate, () => _pickDate(context, false)),
            SizedBox(height: 20.h),

            // Upload section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _uploadTile(Icons.insert_drive_file_outlined, 'Upload File'),
                _uploadTile(Icons.image_outlined, 'Upload Images'),
              ],
            ),
            SizedBox(height: 20.h),

            // Leave Duration
            Row(
              children: [
                Text('Leave Duration :', style: _labelStyle()),
                SizedBox(width: 8.w),
                Radio<bool>(
                  value: true,
                  groupValue: isHalfDay,
                  onChanged: (val) => setState(() => isHalfDay = val!),
                ),
                Text('Half day', style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            SizedBox(height: 16.h),

            // No of Days
            Text('No of Days', style: _labelStyle()),
            SizedBox(height: 8.h),
            _textField(hint: 'Enter number of days'),
            SizedBox(height: 16.h),

            // Reason
            Text('Reason', style: _labelStyle()),
            SizedBox(height: 8.h),
            _textField(hint: 'Type here', maxLines: 3),
            SizedBox(height: 24.h),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _button('Cancel', Colors.white, Colors.black),
                _button('Apply Leave', const Color(0xFFE53935), Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _uploadTile(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 90.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.sp, color: Colors.grey[700]),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField(DateTime date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: _inputDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${date.day}-${_monthAbbr(date.month)}-${date.year}",
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            const Icon(Icons.calendar_today_outlined, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _textField({required String hint, int maxLines = 1}) {
    return Container(
      decoration: _inputDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _button(String text, Color bg, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        height: 48.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(
                color: bg == Colors.white
                    ? Colors.grey.shade400
                    : Colors.transparent,
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _inputDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        
        
      ),
    ],
  );

  TextStyle _labelStyle() => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  String _monthAbbr(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
