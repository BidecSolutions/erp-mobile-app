import 'package:flutter/material.dart';
import 'package:flutter_app/layouts/main_layout.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_screen.dart';
import 'package:flutter_app/screens/notifications_screen.dart';
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
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
