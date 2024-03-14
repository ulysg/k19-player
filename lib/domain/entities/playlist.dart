class Playlist {
  final String id;
  final String? title;

  Playlist({required this.id, this.title});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    try {
      return Playlist(id: json["id"], title: json["title"]);
    } catch (_) {
      throw const FormatException("Failed to load playlist");
    }
  }
}
