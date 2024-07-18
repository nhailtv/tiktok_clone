import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Controllers/auth_controller.dart';
import 'package:tiktok_tutorial/Views/Screens/auth/login_screen.dart';

import '../../../Controllers/theme_controller.dart';
import '../../../constants.dart';
import '../../Widgets/text_input_field.dart';




class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final ThemeController themeController = Get.put(ThemeController());

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      themeController.updateTheme();
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () {
          var backgroundColor = themeController.isDarkMode.value ? Colors.black : Colors.white;
          var buttonColor = themeController.isDarkMode.value? Colors.white:Colors.black;
          var altText = themeController.isDarkMode.value? Colors.greenAccent[400]:Colors.blueAccent[400];
          return Container(

              alignment: Alignment.center,
              color: backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // const SizedBox(
                  //   height: 50,
                  // ),

                  Text(
                    'TikTok_clone',
                    style: TextStyle(
                        fontSize: 35,
                        color: buttonColor,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700,color: altText),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                        () => Stack(
                      children: [
                        GestureDetector(
                          onTap: () => authController.pickImage(),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.black,
                            backgroundImage: authController.pickedPhoto.value != null
                                ? FileImage(authController.pickedPhoto.value!)
                                : AssetImage("images/avatar.gif") as ImageProvider<Object>,
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () => authController.pickImage(),
                            icon: Icon(Icons.add_a_photo_sharp),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _usernameController,
                      labelText: 'Username',
                      icon: Icons.person,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                      onTap: () => authController.registerUser(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          authController.profilePhoto!),
                      child: Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: altText),
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
                        'Đã có tài khoản? ',
                        style: TextStyle(fontSize: 20, color: buttonColor),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            'Đăng nhập. ',
                            style: TextStyle(fontSize: 20, color: altText),
                          ))
                    ],
                  )
                ],
              ),
            );
        }
      ),
    );
  }
}