import 'package:flutter/material.dart';

class AppNavigator {
  static ValueNotifier<int> currentScreenIndex = ValueNotifier(0);
  static ValueNotifier<int> currentTabIndex = ValueNotifier(0);

  // This notifier tells if we’re going forward or backward
  static ValueNotifier<bool> isGoingForward = ValueNotifier(true);

  static void goToScreen(int newIndex) {
    // Detect direction
    isGoingForward.value = newIndex > currentScreenIndex.value;
    currentScreenIndex.value = newIndex;
  }

  static void goToTab(int tabIndex, int screenIndex) {
    isGoingForward.value = true; // Tabs always forward
    currentTabIndex.value = tabIndex;
    currentScreenIndex.value = screenIndex;
  }
}
