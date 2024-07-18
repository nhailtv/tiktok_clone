import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Controllers/auth_controller.dart';
import 'package:tiktok_tutorial/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  // Initialize authController for access to user authentication details
  final authController = Get.find<AuthController>();

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await FirebaseFirestore.instance
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    // Check if current user is following this profile user
    FirebaseFirestore.instance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      isFollowing = value.exists;
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
            (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
            (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }

  Future<void> deleteVideo(String id) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('videos').doc(id).get();
      var uid = authController.user.uid;
      var videoOwner = (doc.data()! as dynamic)['uid'];

      // Check if the video belongs to the current user
      if (videoOwner == uid) {
        await FirebaseFirestore.instance.collection('videos').doc(id).delete();
        Get.snackbar('Success', 'Video deleted successfully');
      } else {
        Get.snackbar('Unauthorized', 'You are not authorized to delete this video.');
      }
    } catch (e) {
      print('Error deleting video: $e');
      Get.snackbar('Failed to delete video', 'Failed to delete video. Please try again.');
    }
  }
}
