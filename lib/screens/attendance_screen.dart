import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _selectedMonth = 'October';

  final List<Map<String, String>> _summaryItems = [
    {
      'title': 'Present',
      'iconBackground': '0xFF8876F0',
      'value': '22 days',
      'color': '0xFFEBE7FF',
      'icon': 'person',
    },
    {
      'title': 'Absent',
      'value': '0 days',
      'color': '0xFFFEEDF3',
      'iconBackground': '0xFFEF79AD',
      'icon': 'person_off',
    },
    {
      'title': 'Late',
      'value': '5 days',
      'color': '0xFFDCF2FF',
      'iconBackground': '0xFF13C5FF',
      'icon': 'access_time',
    },
    {
      'title': 'Half Day',
      'value': '0 days',
      'color': '0xFFD2F3FB',
      'iconBackground': '0xFF65D2ED',
      'icon': 'access_time',
    },
    {
      'title': 'Total Hours',
      'value': '175h 30m',
      'color': '0xFFF1F8EC',
      'iconBackground': '0xFF79AF44',
      'icon': 'timer',
    },
  ];

  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, String>> attendanceList = List.generate(
    6,
    (index) => {
      'date': '0 days',
      'checkIn': '0 days',
      'checkOut': '0 days',
      'total': '0 days',
    },
  );

  Future<void> _selectDate(bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFromDate
          ? fromDate ?? DateTime.now()
          : toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 36.w,
                      width: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Attendance",
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              Container(
                height: 123.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Change Attendance Time",
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Colors.white,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Request Change ›",
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 70.h,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Mark Attendance on Official Duty",
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Colors.white,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Mark On Duty ›",
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // Today's Attendance title
              Text(
                "Today’s Attendance",
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 16.h),

              // Check In / Out cards (no shadow)
              Row(
                children: [
                  Expanded(
                    child: _attendanceCard(
                      icon: Icons.login_rounded,
                      iconColor: const Color(0xFF7ED957),
                      title: "Check In",
                      time: "09:41 AM",
                      subtitle: "On time",
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _attendanceCard(
                      icon: Icons.logout_rounded,
                      iconColor: const Color(0xFFFF8FA3),
                      title: "Check Out",
                      time: "5:51 PM",
                      subtitle: "Off time",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              // Working Hours
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Your Today Working Hours: ",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: "08:10",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // My Attendance Summary section
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Attendance Summary",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),

                  // Month dropdown
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMonth,
                        items:
                            <String>[
                              'January',
                              'February',
                              'March',
                              'April',
                              'May',
                              'June',
                              'July',
                              'August',
                              'September',
                              'October',
                              'November',
                              'December',
                            ].map((String m) {
                              return DropdownMenuItem<String>(
                                value: m,
                                child: Text(
                                  m,
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() {
                            _selectedMonth = val;
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              // 3 cards first row, 2 centered second row
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First Row: 3 Cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _summaryItems.sublist(0, 3).map((item) {
                        return _summaryCard(
                          width: (MediaQuery.of(context).size.width - 24.w) / 3.4,
                          height: 106.h,
                          title: item['title']!,
                          value: item['value']!,
                          color: Color(
                            int.parse(
                              item['color']!.replaceFirst('0x', '0xFF'),
                            ),
                          ),
                          iconBackground: Color(
                            int.parse(
                              item['iconBackground']!.replaceFirst(
                                '0x',
                                '0xFF',
                              ),
                            ),
                          ),
                          iconName: item['icon']!,
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 14.h),

                    // Second Row: 2 Cards Centered
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _summaryItems.sublist(3).map((item) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: _summaryCard(
                            width:
                                (MediaQuery.of(context).size.width - 24.w) / 3,
                            height: 106.h,
                            title: item['title']!,
                            value: item['value']!,
                            color: Color(
                              int.parse(
                                item['color']!.replaceFirst('0x', '0xFF'),
                              ),
                            ),
                            iconBackground: Color(
                              int.parse(
                                item['iconBackground']!.replaceFirst(
                                  '0x',
                                  '0xFF',
                                ),
                              ),
                            ),
                            iconName: item['icon']!,
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 22.h),

                    // Date Pickers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _datePickerButton(
                          label: fromDate != null
                              ? "${fromDate!.day.toString().padLeft(2, '0')}-${_monthName(fromDate!.month)}-${fromDate!.year.toString().substring(2)}"
                              : "From Date",
                          onTap: () => _selectDate(true),
                        ),
                        SizedBox(width: 14.w),
                        _datePickerButton(
                          label: toDate != null
                              ? "${toDate!.day.toString().padLeft(2, '0')}-${_monthName(toDate!.month)}-${toDate!.year.toString().substring(2)}"
                              : "To Date",
                          onTap: () => _selectDate(false),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // ✅ Attendance Table Section (fixed)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 8.w,
                              ),
                              child: Row(
                                children: [
                                  _headerCell("Date"),
                                  _headerCell("Check In"),
                                  _headerCell("Check Out"),
                                  _headerCell("Total Hours"),
                                ],
                              ),
                            ),

                            // Non-scrollable List (renders fast)
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attendanceList.length,
                              separatorBuilder: (_, __) => Divider(
                                height: 0,
                                color: Colors.black,
                                thickness: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final item = attendanceList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 8.w,
                                  ),
                                  child: Row(
                                    children: [
                                      _dataCell(item['date'] ?? '-'),
                                      _dataCell(item['checkIn'] ?? '-'),
                                      _dataCell(item['checkOut'] ?? '-'),
                                      _dataCell(item['total'] ?? '-'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Attendance small card (no shadow)
  Widget _attendanceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 13.5.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 9.h),
          Text(
            time,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 12.5.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Summary card builder (iconName used to pick icon)
  Widget _summaryCard({
    required double width,
    required double height,
    required String title,
    required String value,
    required Color color,
    required Color iconBackground,
    required String iconName,
  }) {
    IconData iconData;
    switch (iconName) {
      case 'person_off':
        iconData = Icons.person_off_rounded;
        break;
      case 'access_time':
        iconData = Icons.access_time_rounded;
        break;
      case 'timer':
        iconData = Icons.timer_rounded;
        break;
      case 'person':
      default:
        iconData = Icons.person;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _datePickerButton({required String label, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 140.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Icon(Icons.calendar_today_rounded, size: 16.sp, color: Colors.black),
        ],
      ),
    ),
  );
}

// Table Header
Widget _headerCell(String text) {
  return Expanded(
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w700,
        fontSize: 13.sp,
        color: Colors.black,
      ),
    ),
  );
}

// Table Data Cell
Widget _dataCell(String text) {
  return Expanded(
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: Colors.black,
      ),
    ),
  );
}

// Month Name Helper
String _monthName(int month) {
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
