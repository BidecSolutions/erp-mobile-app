import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: Padding(
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
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
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
                  color: const Color(0xFF0D8A8A),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              textAlign: TextAlign.start,
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
                    // Divider
                    Container(
                      width: 1,
                      height: 70.h,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    // Right box
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              textAlign: TextAlign.start,
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

              // 📅 Today's Attendance
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

              // 🕒 Check In / Out
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

              // ⏱ Working Hours
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
            ],
          ),
        ),
      ),
    );
  }

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
          SizedBox(height: 10.h),
          Text(
            time,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 12.5.sp,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
