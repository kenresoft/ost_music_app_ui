import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeNotifier extends StateNotifier<bool> {
  LikeNotifier() : super(false);

  like(bool value) => state = value;
}

final isLiked = StateNotifierProvider<LikeNotifier, bool>((ref) => LikeNotifier());
