import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tab State
class TabNotifier extends StateNotifier<int> {
  TabNotifier() : super(0);

  set setTab(int index) => state = index;
}

final tabProvider = StateNotifierProvider<TabNotifier, int>((ref) {
  return TabNotifier();
});
