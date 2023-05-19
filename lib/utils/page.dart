enum NavPage {
  discover,
  library,
  nowPlaying,
  store,
  account,
}

extension PageExtension on NavPage {
  int get page => switch (this) {
        NavPage.discover => 0,
        NavPage.library => 1,
        NavPage.nowPlaying => 2,
        NavPage.store => 3,
        NavPage.account => 4,
        _ => -1,
      };
}
