import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Launched State
class LaunchNotifier extends StateNotifier<bool> {
  LaunchNotifier() : super(false);

  launch(bool value) => state = value;
}

final launchProvider = StateNotifierProvider<LaunchNotifier, bool>((ref) => LaunchNotifier());

