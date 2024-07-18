import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark).obs;

  void updateTheme() {
    isDarkMode.value = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }
}