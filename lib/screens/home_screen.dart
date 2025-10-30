import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cards = [
      {
        "title": "Leave",
        "subtitle": "Simplify time-off requests",
        "icon": Icons.calendar_today_rounded,
        "color": const Color(0xFFFEF2E8),
        "index": 1, // LeaveScreen
      },
      {
        "title": "Attendance",
        "subtitle": "Track daily presence easily",
        "icon": Icons.person_outline,
        "color": const Color(0xFFF1F8EC),
        "index": 11, // AttendanceScreen
      },
      {
        "title": "Payroll",
        "subtitle": "Track monthly salaries",
        "icon": Icons.account_balance_wallet_outlined,
        "color": const Color(0xFFF2F0FE),
        "index": 7, // PayrollScreen
      },
      {
        "title": "Resignation",
        "subtitle": "Employee offboarding",
        "icon": Icons.work_outline,
        "color": const Color(0xFFF2F0FE),
        "index": 8, // ResignationScreen
      },
      {
        "title": "Loan",
        "subtitle": "Simplify loan requests",
        "icon": Icons.monetization_on_outlined,
        "color": const Color(0xFFD2F3FB),
        "index": 10, // LoanScreen
      },
      {
        "title": "Documents",
        "subtitle": "Secure document storage",
        "icon": Icons.insert_drive_file_outlined,
        "color": const Color(0xFFFDEEF3),
        "index": 9, // DocumentsScreen
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side (Hello, Siyam Ahmed)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Siyam Ahmed",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // Right side (Notification + Profile in same container)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.black87,
                              size: 26,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'lib/assets/images/profile.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cards.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.98,
                    ),
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return GestureDetector(
                        onTap: () {
                          final targetIndex = cards[index]['index'];
                          AppNavigator.goToScreen(targetIndex);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: card["color"],
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          padding: EdgeInsets.all(18.w),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon circle
                                  Container(
                                    width: 42.w,
                                    height: 50.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      card["icon"],
                                      color: Colors.black87,
                                      size: 22.sp,
                                    ),
                                  ),

                                  SizedBox(height: 20.h),

                                  // Title & Subtitle
                                  Text(
                                    card["title"],
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontFamily: 'Satoshi',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          card["subtitle"],
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            height: 1.3,
                                            fontFamily: 'Satoshi',
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }, //item builder
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
