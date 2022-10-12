import 'package:get/get.dart';

import '../../../models/playlist.model.dart';

/// Controller of playlist page.
class DesktopPlaylistPageController extends GetxController {
  /// Current showing playlist name.
  final currentPlaylistTableName = ''.obs;

  /// Current showing playlist.
  final currentPlaylist = PlaylistModel().obs;
}
