class Song {
  final String id;
  final String? parent;
  final bool? isDir;
  final String? title;
  final String? album;
  final String? artist;
  final int? track;
  final int? year;
  final int? size;
  final int? duration;

  Song(
      {required this.id,
      this.parent,
      this.isDir,
      this.title,
      this.album,
      this.artist,
      this.track,
      this.year,
      this.size,
      this.duration});

  factory Song.fromJson(Map<String, dynamic> json) {
    try {
      return Song(
          id: json["id"],
          parent: json["parent"],
          isDir: json["isDir"],
          title: json["title"],
          album: json["album"],
          artist: json["artist"],
          track: json["track"],
          year: json["year"],
          size: json["size"],
          duration: json["duration"]);
    } catch (_) {
      throw const FormatException("Failed to load song");
    }
  }
}
