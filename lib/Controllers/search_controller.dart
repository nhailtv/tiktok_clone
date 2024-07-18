import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/user.dart';

class TSearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchUser(String typedUser) {
    firestore.collection('users').get().then((QuerySnapshot querySnapshot) {
      List<User> retVal = [];
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        retVal.add(User.fromSnap(doc));
      });
      // Filter retVal by typedUser
      List<User> filteredUsers = retVal.where((user) =>
          user.name.toLowerCase().contains(typedUser.toLowerCase())).toList();

      _searchedUsers.value = filteredUsers;
    });
  }
}
