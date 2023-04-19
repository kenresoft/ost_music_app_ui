import 'artiste.dart';

class Album {
  const Album({required this.title, required this.image, required this.artiste});

  factory Album.empty() {
    return const Album(title: null, image: null, artiste: null);
  }

  final String? title;
  final String? image;
  final Artiste? artiste;
}
