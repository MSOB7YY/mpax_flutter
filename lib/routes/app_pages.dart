import 'package:get/get.dart';
import 'package:mpax_flutter/views/home_page.dart';
import 'package:mpax_flutter/views/media_library_page.dart';
import 'package:mpax_flutter/views/playlist_page.dart';
import 'package:mpax_flutter/views/scan_page.dart';
import 'package:mpax_flutter/views/settings_page.dart';

part 'app_routes.dart';

class MPaxPages {
  static final List<GetPage> routes = [
    GetPage(
      name: MPaxRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: MPaxRoutes.library,
      page: () => const MediaLibraryPage(),
    ),
    GetPage(
      name: MPaxRoutes.playlist,
      page: () => const PlaylistPage(),
    ),
    GetPage(
      name: MPaxRoutes.scan,
      page: () => const ScanPage(),
    ),
    GetPage(
      name: MPaxRoutes.settings,
      page: () => const SettingsPage(),
    ),
  ];
}
