import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/album.dart';

class CurrentlyPlayingNotifier extends StateNotifier<Album> {
  CurrentlyPlayingNotifier() : super(Album.empty());

  void current(Album album) => state = album;
}

final currentlyPlaying = StateNotifierProvider<CurrentlyPlayingNotifier, Album>((ref) => CurrentlyPlayingNotifier());
