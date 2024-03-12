class Album {
  final String id;
  final String? title;

  Album({required this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      return Album(id: json["id"], title: json["title"]);
    } catch (_) {
      throw const FormatException("Failed to load playlist");
    }
  }
}
