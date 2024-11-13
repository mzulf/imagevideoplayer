import 'package:get/get.dart';
import '../controllers/media_controller.dart';

class MediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MediaController());
  }
}