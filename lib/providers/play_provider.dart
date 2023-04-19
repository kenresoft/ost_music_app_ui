import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Playing State
class PlayNotifier extends StateNotifier<bool> {
  PlayNotifier() : super(true);

  play(bool value) => state = value;
}

final playProvider = StateNotifierProvider<PlayNotifier, bool>((ref) => PlayNotifier());
