import 'package:k19_player/domain/entities/album.dart';

class Artist {
  final String name;
  final String? id;
  final String? coverArt;
  final int? albumCount;
  final String? starred;
  final List<Album>? albums;

  Artist(
      {required this.name,
      this.id,
      this.coverArt,
      this.albumCount,
      this.starred,
      required this.albums});

  factory Artist.fromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey("artist")) {
        return Artist(
            name: json["name"],
            id: json["id"],
            coverArt: json["coverArt"],
            albumCount: json["albumCount"],
            starred: json["starred"],
            albums: []);
      }
      return Artist(
          name: json["name"],
          id: json["id"],
          coverArt: json["coverArt"],
          albumCount: json["albumCount"],
          starred: json["starred"],
          albums: json.containsKey("artist")
              ? List<Album>.from(json["artist"].map((v) => Album.fromJson(v)))
              : null);
    } catch (_) {
      throw const FormatException("Failed to load artist");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'coverArt': coverArt,
      'albumCount': albumCount,
      'starred': starred,
      'albums': albums?.map((album) => album.toJson()).toList(),
    };
  }
}
