import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/Controllers/search_controller.dart';
import 'package:tiktok_tutorial/Views/Screens/profile_screen.dart';

import '../../models/user.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TSearchController searchController = Get.put(TSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextFormField(
            decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18, color: Colors.white)),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhoto,
                        ),
                      ),
                       title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
