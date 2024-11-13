import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../controllers/media_controller.dart';
import '../../widgets/circular_photo_widget.dart';
import '../../widgets/video_player_widget.dart';

class MediaPage extends GetView<MediaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Picker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Tambahkan padding pada body
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: controller.pickImage,
                    icon: Icon(Icons.camera_alt),
                    label: Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.pickVideo,
                    icon: Icon(Icons.videocam),
                    label: Text('Record Video'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Obx(() => controller.selectedImagePath.value.isNotEmpty
                  ? Column(
                children: [
                  CircularPhotoWidget(
                    imagePath: controller.selectedImagePath.value,
                    size: 200,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Get.toNamed(
                      Routes.PREVIEW,
                      arguments: controller.selectedImagePath.value,
                    ),
                    child: Text(
                      'View Full Image',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ),
                ],
              )
                  : Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No image selected',
                  style: TextStyle(color: Colors.grey),
                ),
              )),
              SizedBox(height: 30),
              Obx(() => controller.selectedVideoPath.value.isNotEmpty
                  ? Column(
                children: [
                  VideoPlayerWidget(
                    controller: controller.videoPlayerController.value!,
                    isInitialized: controller.isVideoInitialized.value,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Playing selected video',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )
                  : Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No video selected',
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
