import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:timeago/timeago.dart' as tago;
import '../../Controllers/comment_controller.dart';

class CommentBottomSheet extends StatelessWidget {
  final String id;
  CommentBottomSheet({
    Key? key,
    required this.id,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);

    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapping outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: AnimatedPadding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 200),
        child: SingleChildScrollView(
          child: Container(
            height: size.height * 0.65, // Adjust the height as needed
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return Dismissible(
                          key: Key(comment.id), // Unique key for each comment
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                          confirmDismiss: (direction) async {

                            if (comment.uid == authController.user.uid) {
                              return true;
                            } else {
                              Get.snackbar(
                                'Error',
                                'You can only delete your own comments',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return false;
                            }
                          },
                          onDismissed: (direction) {

                            commentController.deleteComment(comment.id);
                          },
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage:
                                NetworkImage(comment.profilePhoto),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment.comment,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    tago.format(
                                      comment.datePublished.toDate(),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${comment.likes.length} likes',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () =>
                                    commentController.likeComment(comment.id),
                                child: Icon(
                                  comment.likes
                                      .contains(authController.user.uid)
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 25,
                                  color: comment.likes
                                      .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const Divider(),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: TextFormField(
                      controller: _commentController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        commentController.postComment(_commentController.text);
                        _commentController.clear(); // Clear the input field after posting
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
