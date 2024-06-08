  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:firebase_auth/firebase_auth.dart';
  // import 'package:firebase_storage/firebase_storage.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/material.dart';
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
    Text('4th Screen'),
    ProfileScreen(uid: authController.user.uid),
    // Text('Messages Screen'),
    // ProfileScreen(uid: authController.user.uid),



  ];
  // COLORS
  const backgroundColor = Colors.black;
  var buttonColor = Colors.blueAccent[400];
  const borderColor = Colors.grey;



  // FIREBASE
  var firebaseAuth = FirebaseAuth.instance;
  var firebaseStorage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;
  //
  // // CONTROLLER
  var authController = AuthController.instance;