import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Models/video.dart';
import 'package:tiktok_tutorial/constants.dart';


class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(_videoStream());
  }

  @override
  void onClose() {
    // Dispose any resources if needed
    super.onClose();
  }

  Stream<List<Video>> _videoStream() {
    return firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }).handleError((error) {
      // Handle errors here
      print('Error fetching videos: $error');
    });
  }

  Future<void> likeVideo(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
      var uid = authController.user.uid;

      if ((doc.data()! as dynamic)['likes'].contains(uid)) {
        await firestore.collection('videos').doc(id).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await firestore.collection('videos').doc(id).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print('Error liking video: $e');
      Get.snackbar('Failed to like video', 'Failed to like video. Please try again.');
    }
  }

  Future<void> deleteVideo(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
      var uid = authController.user.uid;
      var videoOwner = (doc.data()! as dynamic)['owner'];
        await firestore.collection('videos').doc(id).delete();
        Get.snackbar('Success', 'Video deleted successfully');
    } catch (e) {
      print('Error deleting video: $e');
      Get.snackbar('Failed to delete video', 'Failed to delete video. Please try again.');
    }
  }
}
