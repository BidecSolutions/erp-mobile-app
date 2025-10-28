import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(38.r),
          topRight: Radius.circular(38.r),
        ),
        // ✅ Shadow removed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, Icons.home_outlined, "Home", 0),
          _navItem(Icons.notifications, Icons.notifications_none_outlined, "Notification", 1),
          _navItem(Icons.settings, Icons.settings_outlined, "Settings", 2),
        ],
      ),
    );
  }

  Widget _navItem(IconData filledIcon, IconData outlinedIcon, String label, int index) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabChange(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? filledIcon : outlinedIcon,
            color: isActive ? Colors.black : Colors.grey,
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Satoshi',
              color: isActive ? Colors.black : Colors.grey,
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
