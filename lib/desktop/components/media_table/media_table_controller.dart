import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../models/play_content.model.dart';
import '../../../models/playlist.model.dart';
import '../../../services/media_library_service.dart';
import '../../../services/player_service.dart';

/// Controller of MediaTable.
///
/// Also handle interactive actions from UI with backend services.
/// Including play audio, switch audio, open files, and others.
/// This controller does not become a service because that MediaTable is more
/// one, being a service and refresh different tables is not efficient.
class MediaTableController extends GetxController {
  /// Constructor.
  MediaTableController();

  /// Whether to show filters.
  final showFiltersRow = false.obs;

  /// Current playing audio's filePath.
  ///
  /// If changed, set the same content row in [MediaTable] state to "playing".
  /// If required "scroll table to current playing content", also find that
  /// content by this file path.
  final currentPlayingContent = ''.obs;

  final _playerService = Get.find<PlayerService>();
  final _libraryService = Get.find<MediaLibraryService>();

  /// Save table's [PlutoGridStateManager].
  ///
  /// Didn't want to do this but no other solutions.
  late PlutoGridStateManager? tableStateManager;

  /// Return a sorted [PlaylistModel] with [sort] order in [column].
  Future<PlaylistModel> sort(
    PlaylistModel playlist,
    String column,
    String sort,
  ) async {
    final p = await _libraryService.sortPlaylist(playlist, column, sort);
    // If current playlist is in the table, to ensure update sort, update the
    // [currentPlaylist] in [PlayerService].
    // Otherwise the next or previous audio is wrong.
    // But do not update if current playing playlist is not the one in table.
    if (_playerService.currentPlaylist.tableName == p.tableName) {
      _playerService.currentPlaylist = p;
    }
    await _libraryService.savePlaylist(p);
    return p;
  }

  /// Require [PlayerService] to play specified [content].
  ///
  /// Call may from a double-click on MediaTable, MediaTable item context menu
  /// request or some other thing.
  Future<void> playAudio(PlayContent? content, PlaylistModel playlist) async {
    if (content == null) {
      return;
    }
    await _playerService.setCurrentContent(content, playlist);
    await _playerService.play();
  }

  @override
  void onInit() {
    super.onInit();
    // When current playing audio changes, update currentPlayingContent to
    // notify UI to change state icon.
    _playerService.currentContent.listen((content) {
      currentPlayingContent.value = content.contentPath;
    });
    ever(playlistName, (_) => checkedRowPathList.clear());
  }

  /// Whether the column filters in audio table is visible.
  final searchEnabled = false.obs;

  /// Playlist name to display, readable name, not database table name.
  final playlistName = ''.obs;

  /// Playlist table name to find current page playlist in database.
  final playlistTableName = ''.obs;

  /// Record all checked row's file path in table.
  final checkedRowPathList = <String>[].obs;
}
