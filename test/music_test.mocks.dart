// Mocks generated by Mockito 5.4.4 from annotations
// in k19_player/test/music_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:k19_player/data/repositories/db_repository.dart' as _i9;
import 'package:k19_player/data/repositories/subsonic_repository.dart' as _i6;
import 'package:k19_player/domain/entities/album.dart' as _i4;
import 'package:k19_player/domain/entities/artist.dart' as _i3;
import 'package:k19_player/domain/entities/playlist.dart' as _i2;
import 'package:k19_player/domain/entities/song.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePlaylist_0 extends _i1.SmartFake implements _i2.Playlist {
  _FakePlaylist_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeArtist_1 extends _i1.SmartFake implements _i3.Artist {
  _FakeArtist_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAlbum_2 extends _i1.SmartFake implements _i4.Album {
  _FakeAlbum_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSong_3 extends _i1.SmartFake implements _i5.Song {
  _FakeSong_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_4 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SubsonicRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubsonicRepository extends _i1.Mock
    implements _i6.SubsonicRepository {
  @override
  _i7.Future<List<_i5.Song>> getRandomSongs() => (super.noSuchMethod(
        Invocation.method(
          #getRandomSongs,
          [],
        ),
        returnValue: _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
      ) as _i7.Future<List<_i5.Song>>);

  @override
  _i7.Future<List<_i2.Playlist>> getPlaylists({String? username}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlaylists,
          [],
          {#username: username},
        ),
        returnValue: _i7.Future<List<_i2.Playlist>>.value(<_i2.Playlist>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i2.Playlist>>.value(<_i2.Playlist>[]),
      ) as _i7.Future<List<_i2.Playlist>>);

  @override
  _i7.Future<List<_i4.Album>> getAlbums() => (super.noSuchMethod(
        Invocation.method(
          #getAlbums,
          [],
        ),
        returnValue: _i7.Future<List<_i4.Album>>.value(<_i4.Album>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i4.Album>>.value(<_i4.Album>[]),
      ) as _i7.Future<List<_i4.Album>>);

  @override
  _i7.Future<List<_i3.Artist>> getArtists() => (super.noSuchMethod(
        Invocation.method(
          #getArtists,
          [],
        ),
        returnValue: _i7.Future<List<_i3.Artist>>.value(<_i3.Artist>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i3.Artist>>.value(<_i3.Artist>[]),
      ) as _i7.Future<List<_i3.Artist>>);

  @override
  _i7.Future<_i2.Playlist> getPlaylist(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getPlaylist,
          [id],
        ),
        returnValue: _i7.Future<_i2.Playlist>.value(_FakePlaylist_0(
          this,
          Invocation.method(
            #getPlaylist,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i2.Playlist>.value(_FakePlaylist_0(
          this,
          Invocation.method(
            #getPlaylist,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Playlist>);

  @override
  _i7.Future<List<_i5.Song>> getAllSongs() => (super.noSuchMethod(
        Invocation.method(
          #getAllSongs,
          [],
        ),
        returnValue: _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
      ) as _i7.Future<List<_i5.Song>>);

  @override
  _i7.Future<_i3.Artist> getArtist(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getArtist,
          [id],
        ),
        returnValue: _i7.Future<_i3.Artist>.value(_FakeArtist_1(
          this,
          Invocation.method(
            #getArtist,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i3.Artist>.value(_FakeArtist_1(
          this,
          Invocation.method(
            #getArtist,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.Artist>);

  @override
  _i7.Future<_i4.Album> getAlbum(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getAlbum,
          [id],
        ),
        returnValue: _i7.Future<_i4.Album>.value(_FakeAlbum_2(
          this,
          Invocation.method(
            #getAlbum,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.Album>.value(_FakeAlbum_2(
          this,
          Invocation.method(
            #getAlbum,
            [id],
          ),
        )),
      ) as _i7.Future<_i4.Album>);

  @override
  _i7.Future<_i5.Song> getSong(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getSong,
          [id],
        ),
        returnValue: _i7.Future<_i5.Song>.value(_FakeSong_3(
          this,
          Invocation.method(
            #getSong,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i5.Song>.value(_FakeSong_3(
          this,
          Invocation.method(
            #getSong,
            [id],
          ),
        )),
      ) as _i7.Future<_i5.Song>);

  @override
  _i7.Future<String> getStream(_i5.Song? song) => (super.noSuchMethod(
        Invocation.method(
          #getStream,
          [song],
        ),
        returnValue: _i7.Future<String>.value(_i8.dummyValue<String>(
          this,
          Invocation.method(
            #getStream,
            [song],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<String>.value(_i8.dummyValue<String>(
          this,
          Invocation.method(
            #getStream,
            [song],
          ),
        )),
      ) as _i7.Future<String>);
}

/// A class which mocks [DbRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDbRepository extends _i1.Mock implements _i9.DbRepository {
  @override
  set albums(List<_i4.Album>? _albums) => super.noSuchMethod(
        Invocation.setter(
          #albums,
          _albums,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set playlists(List<_i2.Playlist>? _playlists) => super.noSuchMethod(
        Invocation.setter(
          #playlists,
          _playlists,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set songs(List<_i5.Song>? _songs) => super.noSuchMethod(
        Invocation.setter(
          #songs,
          _songs,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set artists(List<_i3.Artist>? _artists) => super.noSuchMethod(
        Invocation.setter(
          #artists,
          _artists,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Future<dynamic> setLastUpdate(DateTime? dt) => (super.noSuchMethod(
        Invocation.method(
          #setLastUpdate,
          [dt],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<DateTime> getLastUpdate() => (super.noSuchMethod(
        Invocation.method(
          #getLastUpdate,
          [],
        ),
        returnValue: _i7.Future<DateTime>.value(_FakeDateTime_4(
          this,
          Invocation.method(
            #getLastUpdate,
            [],
          ),
        )),
        returnValueForMissingStub: _i7.Future<DateTime>.value(_FakeDateTime_4(
          this,
          Invocation.method(
            #getLastUpdate,
            [],
          ),
        )),
      ) as _i7.Future<DateTime>);

  @override
  _i7.Future<bool> checkIfValueExist(String? value) => (super.noSuchMethod(
        Invocation.method(
          #checkIfValueExist,
          [value],
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);

  @override
  _i7.Future<dynamic> setArtists(List<_i3.Artist>? artists) =>
      (super.noSuchMethod(
        Invocation.method(
          #setArtists,
          [artists],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<dynamic> setSongs(List<_i5.Song>? songs) => (super.noSuchMethod(
        Invocation.method(
          #setSongs,
          [songs],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<dynamic> setPlaylist(List<_i2.Playlist>? playlists) =>
      (super.noSuchMethod(
        Invocation.method(
          #setPlaylist,
          [playlists],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<dynamic> setAlbums(List<_i4.Album>? albums) => (super.noSuchMethod(
        Invocation.method(
          #setAlbums,
          [albums],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);

  @override
  _i7.Future<List<_i5.Song>> getSongs({int? size = -1}) => (super.noSuchMethod(
        Invocation.method(
          #getSongs,
          [],
          {#size: size},
        ),
        returnValue: _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i5.Song>>.value(<_i5.Song>[]),
      ) as _i7.Future<List<_i5.Song>>);

  @override
  _i7.Future<List<_i4.Album>> getAlbums({int? size = -1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAlbums,
          [],
          {#size: size},
        ),
        returnValue: _i7.Future<List<_i4.Album>>.value(<_i4.Album>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i4.Album>>.value(<_i4.Album>[]),
      ) as _i7.Future<List<_i4.Album>>);

  @override
  _i7.Future<List<_i2.Playlist>> getPlaylists({int? size = -1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlaylists,
          [],
          {#size: size},
        ),
        returnValue: _i7.Future<List<_i2.Playlist>>.value(<_i2.Playlist>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i2.Playlist>>.value(<_i2.Playlist>[]),
      ) as _i7.Future<List<_i2.Playlist>>);

  @override
  _i7.Future<List<_i3.Artist>> getArtists({int? size = -1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getArtists,
          [],
          {#size: size},
        ),
        returnValue: _i7.Future<List<_i3.Artist>>.value(<_i3.Artist>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i3.Artist>>.value(<_i3.Artist>[]),
      ) as _i7.Future<List<_i3.Artist>>);

  @override
  _i7.Future<_i4.Album> getAlbum(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getAlbum,
          [id],
        ),
        returnValue: _i7.Future<_i4.Album>.value(_FakeAlbum_2(
          this,
          Invocation.method(
            #getAlbum,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.Album>.value(_FakeAlbum_2(
          this,
          Invocation.method(
            #getAlbum,
            [id],
          ),
        )),
      ) as _i7.Future<_i4.Album>);

  @override
  _i7.Future<_i3.Artist> getArtist(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getArtist,
          [id],
        ),
        returnValue: _i7.Future<_i3.Artist>.value(_FakeArtist_1(
          this,
          Invocation.method(
            #getArtist,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i3.Artist>.value(_FakeArtist_1(
          this,
          Invocation.method(
            #getArtist,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.Artist>);

  @override
  _i7.Future<_i2.Playlist> getPlaylist(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getPlaylist,
          [id],
        ),
        returnValue: _i7.Future<_i2.Playlist>.value(_FakePlaylist_0(
          this,
          Invocation.method(
            #getPlaylist,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i2.Playlist>.value(_FakePlaylist_0(
          this,
          Invocation.method(
            #getPlaylist,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Playlist>);

  @override
  _i7.Future<_i5.Song> getSong(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getSong,
          [id],
        ),
        returnValue: _i7.Future<_i5.Song>.value(_FakeSong_3(
          this,
          Invocation.method(
            #getSong,
            [id],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i5.Song>.value(_FakeSong_3(
          this,
          Invocation.method(
            #getSong,
            [id],
          ),
        )),
      ) as _i7.Future<_i5.Song>);
}
