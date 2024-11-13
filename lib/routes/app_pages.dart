import 'package:get/get.dart';
import '../modules/bindings/media_binding.dart';
import '../modules/views/media_page.dart';
import '../modules/views/preview_page.dart';

abstract class Routes {
  static const MEDIA = '/media';
  static const PREVIEW = '/preview';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.MEDIA,
      page: () => MediaPage(),
      binding: MediaBinding(),
    ),
    GetPage(
      name: Routes.PREVIEW,
      page: () => PreviewPage(),
    ),
  ];
}