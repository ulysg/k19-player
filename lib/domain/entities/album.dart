import 'package:k19_player/domain/entities/song.dart';

class Album {
  final String id;
  final String? title;
  final String? parent;
  final String? name;
  final bool? isDir;
  final String? coverArt;
  final int? songCount;
  final String? created;
  final int? duration;
  final int? playCount;
  final String? artistId;
  final String? artist;
  final int? year;
  final String? genre;
  final List<Song> song;

  Album({
    required this.id,
    this.title,
    this.parent,
    this.name,
    this.isDir,
    this.coverArt,
    this.songCount,
    this.created,
    this.duration,
    this.playCount,
    this.artistId,
    this.artist,
    this.year,
    this.genre,
    required this.song,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      parent: json['parent'],
      name: json['name'],
      isDir: json['isDir'],
      coverArt: json['coverArt'],
      songCount: json['songCount'],
      created: json['created'],
      duration: json['duration'],
      playCount: json['playCount'],
      artistId: json['artistId'],
      artist: json['artist'],
      year: json['year'],
      genre: json['genre'],
      song: json.containsKey("song")
          ? json["song"].map<Song>((v) => Song.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'parent': parent,
      'name': name,
      'isDir': isDir,
      'coverArt': coverArt,
      'songCount': songCount,
      'created': created,
      'duration': duration,
      'playCount': playCount,
      'artistId': artistId,
      'artist': artist,
      'year': year,
      'genre': genre,
      'song': song.map((song) => song.toJson()).toList(),
    };
  }
}
