import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Controllers/auth_controller.dart';
import 'package:tiktok_tutorial/Views/Screens/auth/login_screen.dart';
import 'package:tiktok_tutorial/Views/Screens/auth/register_screen.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'Controllers/theme_controller.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(ThemeController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Tiktok Clone",
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: themeController.isDarkMode.value ? Colors.black : Colors.white,
            // Add other theme configurations as needed
          ),
          home: LoginScreen(),
        );
      },
    );
  }
}
