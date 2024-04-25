import 'package:k19_player/domain/entities/album.dart';

class Artist {
  final String name;
  final String? id;
  final String? coverArt;
  final int? albumCount;
  final String? starred;
  final List<Album> album;

  Artist(
      {required this.name,
      this.id,
      this.coverArt,
      this.albumCount,
      this.starred,
      required this.album});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
        name: json["name"],
        id: json["id"],
        coverArt: json["coverArt"],
        albumCount: json["albumCount"],
        starred: json["starred"],
        album: json.containsKey("album")
            ? List<Album>.from(json["album"].map((v) => Album.fromJson(v)))
            : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'coverArt': coverArt,
      'albumCount': albumCount,
      'starred': starred,
      'album': album.map((album) => album.toJson()).toList(),
    };
  }
}
