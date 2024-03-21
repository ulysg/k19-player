const Map<String, dynamic> responseGetRandomSongs = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "randomSongs": {
    "song": [
      {
        "id": "300000060",
        "albumId": "200000002",
        "duration": 304,
      },
      {
        "id": "300000055",
        "albumId": "200000002",
        "duration": 400,
      }
    ]
  }
};
const Map<String, dynamic> responseGetPlaylists = {
  "status": "ok",
  "version": "1.16.1",
  "playlists": {
    "playlist": [
      {
        "id": "800000003",
        "name": "random - admin - private (admin)",
        "owner": "admin",
        "public": false,
        "created": "2021-02-23T04:35:38+00:00",
        "changed": "2021-02-23T04:35:38+00:00",
        "songCount": 43,
        "duration": 17875
      },
      {
        "id": "800000002",
        "name": "random - admin - public (admin)",
        "owner": "admin",
        "public": true,
        "created": "2021-02-23T04:34:56+00:00",
        "changed": "2021-02-23T04:34:56+00:00",
        "songCount": 43,
        "duration": 17786
      }
    ]
  }
};
const Map<String, dynamic> responseGetAlbums = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "albumList": {
    "album": [
      {
        "id": "200000021",
        "parent": "100000036",
        "album": "Forget and Remember",
        "title": "Forget and Remember",
        "name": "Forget and Remember",
        "isDir": true,
        "coverArt": "al-200000021",
        "songCount": 20,
        "created": "2021-07-22T02:09:31+00:00",
        "duration": 4248,
        "playCount": 0,
        "artistId": "100000036",
        "artist": "Comfort Fit",
        "year": 2005,
        "genre": "Hip-Hop"
      },
      {
        "id": "200000012",
        "parent": "100000019",
        "album": "Buried in Nausea",
        "title": "Buried in Nausea",
        "name": "Buried in Nausea",
        "isDir": true,
        "coverArt": "al-200000012",
        "songCount": 9,
        "created": "2021-02-24T01:44:21+00:00",
        "duration": 1879,
        "playCount": 0,
        "artistId": "100000019",
        "artist": "Various Artists",
        "year": 2012,
        "genre": "Punk"
      }
    ]
  }
};
const Map<String, dynamic> responseGetArtists = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "artists": {
    "ignoredArticles": "The An A Die Das Ein Eine Les Le La",
    "index": [
      {
        "name": "C",
        "artist": [
          {
            "id": "100000016",
            "name": "CARNÚN",
            "coverArt": "ar-100000016",
            "albumCount": 1
          },
          {
            "id": "100000027",
            "name": "Chi.Otic",
            "coverArt": "ar-100000027",
            "albumCount": 0
          }
        ]
      },
      {
        "name": "I",
        "artist": [
          {
            "id": "100000013",
            "name": "IOK-1",
            "coverArt": "ar-100000013",
            "albumCount": 1
          }
        ]
      }
    ]
  }
};
const Map<String, dynamic> responseGetPlaylist = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "playlist": {
    "id": "800000075",
    "name": "testcreate",
    "owner": "user",
    "public": true,
    "created": "2023-03-16T03:18:41+00:00",
    "changed": "2023-03-16T03:18:41+00:00",
    "songCount": 1,
    "duration": 304,
    "entry": [
      {
        "id": "300000060",
        "parent": "200000002",
        "title": "BrownSmoke",
        "isDir": false,
        "isVideo": false,
        "type": "music",
        "albumId": "200000002",
        "album": "Colorsmoke EP",
        "artistId": "100000002",
        "artist": "Synthetic",
        "coverArt": "300000060",
        "duration": 304,
        "bitRate": 20,
        "userRating": 5,
        "averageRating": 5,
        "track": 4,
        "year": 2007,
        "genre": "Electronic",
        "size": 792375,
        "discNumber": 1,
        "suffix": "wma",
        "contentType": "audio/x-ms-wma",
        "path":
            "Synthetic/Synthetic_-_Colorsmoke_EP-20k217-2007/04-Synthetic_-_BrownSmokeYSBM20k22khS.wma"
      }
    ]
  }
};
const Map<String, dynamic> responseGetAllSongs = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "directory": {
    "id": "1",
    "name": "music",
    "child": [
      {
        "id": "100000016",
        "parent": "1",
        "isDir": true,
        "title": "CARNÚN",
        "artist": "CARNÚN",
        "coverArt": "ar-100000016"
      },
      {
        "id": "100000027",
        "parent": "1",
        "isDir": true,
        "title": "Chi.Otic",
        "artist": "Chi.Otic",
        "coverArt": "ar-100000027"
      }
    ]
  }
};
const Map<String, dynamic> responseGetArtist = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "artist": {
    "id": "100000002",
    "name": "Synthetic",
    "coverArt": "ar-100000002",
    "albumCount": 1,
    "starred": "2021-02-22T05:54:18Z",
    "album": [
      {
        "id": "200000002",
        "parent": "100000002",
        "album": "Colorsmoke EP",
        "title": "Colorsmoke EP",
        "name": "Colorsmoke EP",
        "isDir": true,
        "coverArt": "al-200000002",
        "songCount": 12,
        "created": "2021-02-23T04:24:48+00:00",
        "duration": 4568,
        "playCount": 1,
        "artistId": "100000002",
        "artist": "Synthetic",
        "year": 2007,
        "genre": "Electronic",
        "userRating": 5,
        "averageRating": 3,
        "starred": "2021-02-22T05:51:53Z"
      }
    ]
  }
};
const Map<String, dynamic> responseGetAlbum = {
  "status": "ok",
  "version": "1.16.1",
  "type": "AwesomeServerName",
  "serverVersion": "0.1.3 (tag)",
  "openSubsonic": true,
  "album": {
    "id": "200000021",
    "parent": "100000036",
    "album": "Forget and Remember",
    "title": "Forget and Remember",
    "name": "Forget and Remember",
    "isDir": true,
    "coverArt": "al-200000021",
    "songCount": 20,
    "created": "2021-07-22T02:09:31+00:00",
    "duration": 4248,
    "playCount": 0,
    "artistId": "100000036",
    "artist": "Comfort Fit",
    "year": 2005,
    "genre": "Hip-Hop",
    "song": [
      {
        "id": "300000116",
        "parent": "200000021",
        "title": "Can I Help U?",
        "isDir": false,
        "isVideo": false,
        "type": "music",
        "albumId": "200000021",
        "album": "Forget and Remember",
        "artistId": "100000036",
        "artist": "Comfort Fit",
        "coverArt": "300000116",
        "duration": 103,
        "bitRate": 216,
        "track": 1,
        "year": 2005,
        "genre": "Hip-Hop",
        "size": 2811819,
        "discNumber": 1,
        "suffix": "mp3",
        "contentType": "audio/mpeg",
        "path": "user/Comfort Fit/Forget And Remember/1 - Can I Help U?.mp3"
      },
      {
        "id": "300000121",
        "parent": "200000021",
        "title": "Planetary Picknick",
        "isDir": false,
        "isVideo": false,
        "type": "music",
        "albumId": "200000021",
        "album": "Forget and Remember",
        "artistId": "100000036",
        "artist": "Comfort Fit",
        "coverArt": "300000121",
        "duration": 358,
        "bitRate": 238,
        "track": 2,
        "year": 2005,
        "genre": "Hip-Hop",
        "size": 10715592,
        "discNumber": 1,
        "suffix": "mp3",
        "contentType": "audio/mpeg",
        "path":
            "user/Comfort Fit/Forget And Remember/2 - Planetary Picknick.mp3"
      }
    ]
  }
};
const Map<String, dynamic> responseGetSong = {
  "status": "ok",
  "version": "1.16.1",
  "type": "navidrome",
  "serverVersion": "0.51.1 (6d253225)",
  "openSubsonic": true,
  "song": {
    "id": "191c92ba5a4d9aea628802033a9c0503",
    "parent": "b87a936c682c49d4494c7ccb08c22d23",
    "isDir": false,
    "title": "Ready To Lose",
    "album": "Shaking The Habitual",
    "artist": "The Knife",
    "track": 13,
    "year": 2013,
    "genre": "Electronic",
    "coverArt": "al-b87a936c682c49d4494c7ccb08c22d23_0",
    "size": 8740691,
    "contentType": "audio/mp4",
    "suffix": "m4a",
    "starred": "2023-12-09T19:16:44Z",
    "duration": 275,
    "bitRate": 257,
    "path": "The Knife/Shaking The Habitual/13 - Ready To Lose.m4a",
    "created": "2023-03-10T02:18:28.769295019Z",
    "albumId": "b87a936c682c49d4494c7ccb08c22d23",
    "artistId": "b29e9a9d780cb0e133f3add5662771b9",
    "type": "music",
    "isVideo": false,
    "bpm": 0,
    "comment": "",
    "sortName": "",
    "mediaType": "song",
    "musicBrainzId": "",
    "genres": [
      {"name": "Electronic"}
    ],
    "replayGain": {"trackPeak": 1, "albumPeak": 1}
  }
};
