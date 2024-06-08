  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:tiktok_tutorial/Controllers/auth_controller.dart';
  import 'package:tiktok_tutorial/Views/Screens/auth/login_screen.dart';

  import '../../../constants.dart';
  import '../../Widgets/text_input_field.dart';

  class RegisterScreen extends StatelessWidget {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();

    RegisterScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TikTok_clone',
                  style: TextStyle(
                      fontSize: 35,
                      color: buttonColor,
                      fontWeight: FontWeight.w900),
                ),
                const Text(
                  'Đăng ký',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
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
                          backgroundColor: Colors.white,
                          backgroundImage: authController.pickedPhoto != null
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
                    child: const Center(
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                    const Text(
                      'Đã có tài khoản? ',
                      style: TextStyle(fontSize: 20),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          'Đăng nhập. ',
                          style: TextStyle(fontSize: 20, color: buttonColor),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }