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
  final List<Song>? songs;

  Playlist({
    required this.id,
    this.name,
    this.owner,
    this.public,
    this.created,
    this.changed,
    this.songCount,
    this.duration,
    this.songs,
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
      songs: json.containsKey("entry")
          ? List<Song>.from(json["entry"].map((v) => Song.fromJson(v)))
          : null,
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
      'songs': songs?.map((song) => song.toJson()).toList(),
    };
  }
}
