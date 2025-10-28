import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "⚙️ Settings Screen",
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
