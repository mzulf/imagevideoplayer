import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';

class MediaController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final storage = GetStorage();

  Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  RxString selectedImagePath = ''.obs;
  RxString selectedVideoPath = ''.obs;
  RxBool isVideoInitialized = false.obs;

  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
      // Save to storage
      storage.write('lastImagePath', image.path);
    }
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      selectedVideoPath.value = video.path;
      // Initialize video player
      videoPlayerController.value?.dispose();
      videoPlayerController.value = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          isVideoInitialized.value = true;
          update();
        });
      // Save to storage
      storage.write('lastVideoPath', video.path);
    }
  }

  Future<void> loadLastMedia() async {
    final lastImagePath = storage.read('lastImagePath');
    final lastVideoPath = storage.read('lastVideoPath');

    if (lastImagePath != null) {
      selectedImagePath.value = lastImagePath;
    }

    if (lastVideoPath != null) {
      selectedVideoPath.value = lastVideoPath;
      videoPlayerController.value = VideoPlayerController.file(File(lastVideoPath))
        ..initialize().then((_) {
          isVideoInitialized.value = true;
          update();
        });
    }
  }
}