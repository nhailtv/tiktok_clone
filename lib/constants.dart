  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:firebase_auth/firebase_auth.dart';
  // import 'package:firebase_storage/firebase_storage.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/scheduler.dart';
  import 'package:tiktok_tutorial/Views/Screens/add_video_screen.dart';

  import 'package:tiktok_tutorial/Views/Screens/profile_screen.dart';
  import 'package:tiktok_tutorial/Views/Screens/search_screen.dart';
  import 'Controllers/auth_controller.dart';
  import 'Views/Screens/video_screen.dart';
  // import 'package:tiktok_tutorial/controllers/auth_controller.dart';
  // import 'package:tiktok_tutorial/views/screens/add_video_screen.dart';
  // import 'package:tiktok_tutorial/views/screens/profile_screen.dart';
  // import 'package:tiktok_tutorial/views/screens/search_screen.dart';
  // import 'package:tiktok_tutorial/views/screens/video_screen.dart';

  List pages = [
    VideoScreen(),
    SearchScreen(),
    const AddVideoScreen(),
    const Text("Building..."),
    ProfileScreen(uid: authController.user.uid),
  ];
  // COLORS

  // var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  // bool isDarkMode = brightness == Brightness.dark;
  // var backgroundColor = isDarkMode ? Colors.black : Colors.white;



  // var buttonColor = Colors.greenAccent[400];
  const borderColor = Colors.black;



  // FIREBASE
  var firebaseAuth = FirebaseAuth.instance;
  var firebaseStorage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;
  //
  // // CONTROLLER
  var authController = AuthController.instance;