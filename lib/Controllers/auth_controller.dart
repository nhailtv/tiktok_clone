import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tutorial/constants.dart';

import '../Models/user.dart' as model;
import '../Views/Screens/auth/login_screen.dart';
import '../Views/Screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage = Rx<File?>(null);
  Rx<File?> get pickedPhoto => _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  User get user => _user.value!;


  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }


  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.snackbar(
          "Thành công!",
          "Tạo tài khoản thành công!!",
          backgroundColor: Colors.green, // Set your desired background color
        );
      } else {
        Get.snackbar(
          'Lỗi tạo tài khoản',
          'Vui lòng nhập đầy đủ thông tin',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = getMessageFromErrorCode(e.code);
      } else {
        errorMessage = 'Đã xảy ra lỗi, vui lòng thử lại.';
      }

      Get.snackbar(
        'Lỗi tạo tài khoản',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      );
    }
  }


  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email đã được sử dụng. Vui lòng truy cập trang đăng nhập.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Sai email hoặc mật khẩu.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "Không tìm thấy người dùng với email này.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "Người dùng này đã bị vô hiệu hóa.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
        return "Quá nhiều yêu cầu, vui lòng thử lại sau.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Lỗi máy chủ, vui lòng thử lại sau.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email không hợp lệ.";
      default:
        return "Đăng nhập thất bại. Vui lòng thử lại.";
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        print('Đăng nhập thành công');
      } else {
        Get.snackbar(
          'Lỗi đăng nhập',
          'Vui lòng nhập đầy đủ thông tin',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = getMessageFromErrorCode(e.code);
      } else {
        errorMessage = 'Đã xảy ra lỗi, vui lòng thử lại.';
      }

      Get.snackbar(
        'Lỗi đăng nhập',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
