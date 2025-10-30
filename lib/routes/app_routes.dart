import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/main_layout.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_screen.dart';
import 'package:flutter_app/screens/attendance_screen.dart';
import 'package:flutter_app/screens/documents_screen.dart';
import 'package:flutter_app/screens/loan_screen.dart';
import 'package:flutter_app/screens/notifications_screen.dart';
import 'package:flutter_app/screens/payroll_screen.dart';
import 'package:flutter_app/screens/resignation_screen.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_form_screen.dart';
// ✅ for MainPage

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainPage()); // ✅ correct
      case '/leave':
        return MaterialPageRoute(builder: (_) => const LeaveScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/leaveForm':
        return MaterialPageRoute(builder: (_) => const LeaveFormScreen());
      case '/attendance':
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case '/payroll':
        return MaterialPageRoute(builder: (_) => const PayrollScreen());
      case '/loan':
        return MaterialPageRoute(builder: (_) => const LoanScreen());
      case '/documents':
        return MaterialPageRoute(builder: (_) => const DocumentsScreen());
      case '/resignation':
        return MaterialPageRoute(builder: (_) => const ResignationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
