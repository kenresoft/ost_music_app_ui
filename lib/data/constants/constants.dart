import 'package:ost_music_app_ui/data/models/artiste.dart';

import '../models/album.dart';

class Constants {
  Constants._();

  static const String appName = 'OST Music App UI';
  static const String root = '/';

  //Navigation routes
  static const String library = '/library';
  static const String discover = '/discover';
  static const String playlist = '/playlist';
  static const String nowPlaying = '/nowPlaying';
  static const String error = '/error';

  //Images route
  static const String imageDir = "assets/images";
  static const String iconDir = "assets/icons";

  //Images
  static const String profile = "$imageDir/profile.png";
  static const String wave = "$imageDir/music_wave.png";
  static const String album = "$imageDir/album.jpg";

  static Map<String, String> get image {
    var map = <String, String>{};
    for (var i = 1; i <= 4; ++i) {
      map['art$i'] = '$imageDir/art_$i.jpg';
    }
    return map;
  }

  static List<String> images = image.values.toList();

  //Icons
  static const String appIcon = "$iconDir/icon.png";

  static List<Album> albumList = [
    Album(title: "Furious 7", image: images[0], artiste: artisteList[0]),
    Album(title: "Final Fantasy", image: images[1], artiste: artisteList[1]),
    Album(title: "Fifty Shades", image: images[2], artiste: artisteList[2]),
    Album(title: "Blade Runner", image: images[3], artiste: artisteList[3]),
    Album(title: "Manchester by the Sea Chorale", image: images[0], artiste: artisteList[4]),
    Album(title: "Final Fantasy", image: images[1], artiste: artisteList[1]),
    Album(title: "Fifty Shades", image: images[2], artiste: artisteList[2]),
    Album(title: "Blade Runner", image: images[3], artiste: artisteList[3]),
  ];

  static const List<Artiste> artisteList = [
    Artiste(name: 'Kim Min Jun', image: profile),
    Artiste(name: 'Nobuo Lilian', image: profile),
    Artiste(name: 'Craig Martins', image: profile),
    Artiste(name: 'Rose Jones', image: profile),
    Artiste(name: 'Lesley Barber', image: profile),
  ];

  static const double wrapWidth = 105;

  static const Artiste getArtiste = Artiste(name: 'Kim Min Jun', image: profile);
  static Album getAlbums = Album(title: "Furious 7", image: image['art3'], artiste: getArtiste);
}
