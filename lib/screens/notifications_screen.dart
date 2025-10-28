import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "🔔 Notifications Screen",
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
