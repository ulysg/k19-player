import "package:k19_player/domain/entities/media.dart";

class Song extends Media {
  final String id;
  final String? parent;
  final bool? isDir;
  final bool? isVideo;
  final String? type;
  final String? albumId;
  final String? album;
  final String? artistId;
  final String? artist;
  final String? coverArt;
  final int? duration;
  final int? bitRate;
  final int? userRating;
  final int? averageRating;
  final String? title;
  final int? track;
  final int? year;
  final String? genre;
  final int? size;
  final int? discNumber;
  final String? suffix;
  final String? contentType;
  final String? path;

  Song({
    required this.id,
    this.parent,
    this.isDir,
    this.isVideo,
    this.type,
    this.albumId,
    this.album,
    this.artistId,
    this.artist,
    this.coverArt,
    this.duration,
    this.bitRate,
    this.userRating,
    this.averageRating,
    this.title,
    this.track,
    this.year,
    this.genre,
    this.size,
    this.discNumber,
    this.suffix,
    this.contentType,
    this.path,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      parent: json['parent'],
      isDir: json['isDir'],
      isVideo: json['isVideo'],
      type: json['type'],
      albumId: json['albumId'],
      album: json['album'],
      artistId: json['artistId'],
      artist: json['artist'],
      coverArt: json['coverArt'],
      duration: json['duration'],
      bitRate: json['bitRate'],
      userRating: json['userRating'],
      averageRating: json['averageRating'],
      title: json['title'],
      track: json['track'],
      year: json['year'],
      genre: json['genre'],
      size: json['size'],
      discNumber: json['discNumber'],
      suffix: json['suffix'],
      contentType: json['contentType'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent': parent,
      'isDir': isDir,
      'isVideo': isVideo,
      'type': type,
      'albumId': albumId,
      'album': album,
      'artistId': artistId,
      'artist': artist,
      'coverArt': coverArt,
      'duration': duration,
      'bitRate': bitRate,
      'userRating': userRating,
      'averageRating': averageRating,
      'title': title,
      'track': track,
      'year': year,
      'genre': genre,
      'size': size,
      'discNumber': discNumber,
      'suffix': suffix,
      'contentType': contentType,
      'path': path,
    };
  }
}
