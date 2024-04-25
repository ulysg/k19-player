import 'package:k19_player/domain/entities/song.dart';

class Playlist {
  final String id;
  final String? name;
  final String? owner;
  final bool? public;
  final String? created;
  final String? changed;
  final int? songCount;
  final int? duration;
  final String? coverArt;
  final List<Song> song;

  Playlist({
    required this.id,
    this.name,
    this.owner,
    this.public,
    this.created,
    this.changed,
    this.songCount,
    this.duration,
    this.coverArt,
    required this.song,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      public: json['public'],
      created: json['created'],
      changed: json['changed'],
      songCount: json['songCount'],
      duration: json['duration'],
      coverArt: json['coverArt'],
      song: json.containsKey("entry")
          ? List<Song>.from(json["entry"].map((v) => Song.fromJson(v)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'public': public,
      'created': created,
      'changed': changed,
      'songCount': songCount,
      'duration': duration,
      'coverArt': coverArt,
      'entry': song.map((song) => song.toJson()).toList(),
    };
  }
}
