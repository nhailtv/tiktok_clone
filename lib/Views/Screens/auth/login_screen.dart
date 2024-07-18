import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_tutorial/Views/Screens/auth/register_screen.dart';
import 'package:tiktok_tutorial/Views/Widgets/text_input_field.dart';
import 'package:tiktok_tutorial/constants.dart';

import '../../../Controllers/theme_controller.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ThemeController themeController = Get.put(ThemeController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      themeController.updateTheme();
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        var backgroundColor = themeController.isDarkMode.value ? Colors.black : Colors.white;
        var buttonColor = themeController.isDarkMode.value? Colors.white:Colors.black;
        var altText = themeController.isDarkMode.value? Colors.greenAccent[400]:Colors.blueAccent[400];


        return Container(
          alignment: Alignment.center,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),

              Image.asset(
                "images/TikTok-Logo.png",
                width: 150,
              ),
              const SizedBox(
                height: 50,
              ),

              Text(
                "Đăng nhập vào TikTok",
                style: GoogleFonts.oswald(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 22,
              ),

              Text(
                "Quản lí tài khoản, kiểm tra thông báo,\n"
                    "     bình luận trên các video, v.v.",
                style: GoogleFonts.robotoCondensed(
                  fontSize: 16,
                  color: const Color(0xFF525252),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email_rounded,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.password_rounded,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    )),
                child: InkWell(
                  onTap: () => authController.loginUser(
                      _emailController.text, _passwordController.text),
                  child:  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color:altText ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Không có tài khoản? ',
                    style: TextStyle(fontSize: 20 , color: buttonColor),
                  ),
                  InkWell(
                      onTap: () => Get.to(RegisterScreen()),
                      child: Text(
                        'Đăng ký ngay! ',
                        style: TextStyle(fontSize: 20, color: altText),
                      ))
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
