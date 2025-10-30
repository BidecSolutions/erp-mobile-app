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
      child: AnimatedScale(
        scale: isActive ? 1.1 : 1.0, 
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Icon(
                isActive ? filledIcon : outlinedIcon,
                color: isActive ? Colors.black : Colors.grey,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontFamily: 'Satoshi',
                color: isActive ? Colors.black : Colors.grey,
                fontSize: isActive ? 13.5.sp : 12.5.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
