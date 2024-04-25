import 'package:flutter_test/flutter_test.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';

void main() {
  group("Album", () {
    test("Serialize && Deserialize", () {
      List<Album> albums = [
        Album(id: "ok", song: [Song(id: "yes")])
      ];
      List<Map<String, dynamic>> serial =
          albums.map<Map<String, dynamic>>((v) => v.toJson()).toList();
      List<Album> result = serial.map<Album>((v) => Album.fromJson(v)).toList();

      expect(result[0].id, albums[0].id);
      expect(result[0].song[0].id, albums[0].song[0].id);
    });
  });

  group("Artist", () {
    test("Serialize && Deserialize", () {
      List<Album> albums = [
        Album(id: "ok", song: [Song(id: "yes")])
      ];
      List<Artist> artists = [Artist(name: "artist", album: albums)];
      List<Map<String, dynamic>> serial =
          artists.map<Map<String, dynamic>>((v) => v.toJson()).toList();
      List<Artist> result =
          serial.map<Artist>((v) => Artist.fromJson(v)).toList();

      expect(result[0].id, artists[0].id);
      expect(result[0].album[0].id, artists[0].album[0].id);
      expect(result[0].album[0].id, artists[0].album[0].id);
      expect(result[0].album[0].song[0].id, artists[0].album[0].song[0].id);
    });
  });
  group("Playlist", () {
    test("Serialize && Deserialize", () {
      List<Playlist> playlists = [
        Playlist(id: "ok", song: [Song(id: "yes")])
      ];
      List<Map<String, dynamic>> serial =
          playlists.map<Map<String, dynamic>>((v) => v.toJson()).toList();
      List<Playlist> result =
          serial.map<Playlist>((v) => Playlist.fromJson(v)).toList();

      expect(result[0].id, playlists[0].id);
      expect(result[0].song[0].id, playlists[0].song[0].id);
    });
  });
  group("Song", () {
    test("Serialize && Deserialize", () {
      List<Album> albums = [
        Album(id: "ok", song: [Song(id: "yes")])
      ];
      List<Map<String, dynamic>> serial =
          albums.map<Map<String, dynamic>>((v) => v.toJson()).toList();
      List<Album> result = serial.map<Album>((v) => Album.fromJson(v)).toList();

      expect(result[0].id, albums[0].id);
      expect(result[0].song[0].id, albums[0].song[0].id);
    });
  });
}
