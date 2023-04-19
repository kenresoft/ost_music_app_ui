enum NavPage {
  discover,
  library,
  nowPlaying,
  store,
  account,
}

extension PageExtension on NavPage {
  int get page {
    switch (this) {
      case NavPage.discover:
        return 0;
      case NavPage.library:
        return 1;
      case NavPage.nowPlaying:
        return 2;
      case NavPage.store:
        return 3;
      case NavPage.account:
        return 4;
      default:
        return 0;
    }
  }
}
