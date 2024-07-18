import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/controllers/upload_video_controller.dart';
import 'package:tiktok_tutorial/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  bool isUploading = false; // Track upload state

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile);
    controller.initialize().then((_) {
      setState(() {});
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _uploadVideo() async {
    setState(() {
      isUploading = true; // Start uploading, show loading indicator
    });

    try {
      await uploadVideoController.uploadVideo(
        _songController.text,
        _captionController.text,
        widget.videoPath,
      );

      // Upload complete, navigate back
      Get.back();
    } catch (e) {
      // Handle upload error
      print('Error uploading video: $e');
      // Optionally show error message
    } finally {
      setState(() {
        isUploading = false; // Upload process finished
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: VideoPlayer(controller),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width - 20,
                        child: TextInputField(
                          controller: _songController,
                          labelText: 'Song Name',
                          icon: Icons.music_note,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width - 20,
                        child: TextInputField(
                          controller: _captionController,
                          labelText: 'Caption',
                          icon: Icons.closed_caption,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: isUploading ? null : _uploadVideo,
                        child: Text(
                          'Share!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isUploading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
