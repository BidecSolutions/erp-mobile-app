import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/navigation_controller.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_form_screen.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_history_screen.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_screen.dart';
import 'package:flutter_app/screens/attendance_screen.dart';
import 'package:flutter_app/screens/documents_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/loan_screen.dart';
import 'package:flutter_app/screens/notifications_screen.dart';
import 'package:flutter_app/screens/payroll_screen.dart';
import 'package:flutter_app/screens/resignation_screen.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter_app/screens/Leave_Screens/leave_reversal_screen.dart';
import 'package:flutter_app/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _screens = [
    const HomeScreen(key: ValueKey('home')),
    const LeaveScreen(key: ValueKey('leave')),
    const LeaveFormScreen(key: ValueKey('leave_form')),
    const LeaveHistoryScreen(key: ValueKey('leave_history')),
    const NotificationsScreen(key: ValueKey('notifications')),
    const SettingsScreen(key: ValueKey('settings')),
    const LeaveReversalScreen(key: ValueKey('leave_reversal')),
    const PayrollScreen(key: ValueKey('payroll')),
    const ResignationScreen(key: ValueKey('resignation')),
    const DocumentsScreen(key: ValueKey('documents')),
    const LoanScreen(key: ValueKey('loan')),
    const AttendanceScreen(key: ValueKey('attendance')),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppNavigator.currentScreenIndex,
      builder: (context, screenIndex, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: AppNavigator.isGoingForward,
          builder: (context, isForward, __) {
            return Scaffold(
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  final offsetTween = Tween<Offset>(
                    begin: isForward
                        ? const Offset(1.0, 0.0)
                        : const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  );

                  return SlideTransition(
                    position: offsetTween.animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: _screens[screenIndex],
              ),
              bottomNavigationBar: ValueListenableBuilder<int>(
                valueListenable: AppNavigator.currentTabIndex,
                builder: (context, tabIndex, _) {
                  return CustomBottomNavBar(
                    selectedIndex: tabIndex,
                    onTabChange: (index) {
                      switch (index) {
                        case 0:
                          AppNavigator.goToTab(0, 0);
                          break;
                        case 1:
                          AppNavigator.goToTab(1, 4);
                          break;
                        case 2:
                          AppNavigator.goToTab(2, 5);
                          break;
                      }
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
