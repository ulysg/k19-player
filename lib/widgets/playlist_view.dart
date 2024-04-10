import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/data/repositories/subsonic_repository.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:k19_player/widgets/small_player.dart";
import "package:provider/provider.dart";

class PlaylistList extends StatelessWidget {
  const PlaylistList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, List<Playlist>>(
      selector: (_, contentModel) => contentModel.playlists,

      builder: (context, playlists, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: playlists.length,

          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,

              onTap: () async {
                Navigator.push(
                  context,
                
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(playlists[index].name ?? "")
                        ),

                        body: Padding(
                          padding: const EdgeInsets.all(24),

                          child: PlaylistView(playlist: playlists[index])
                        )
                      );
                    }
                  )
                );
              },

              child: PlaylistThumbnail(playlist: playlists[index])
            );
          },

          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }
    );
  }
}

class PlaylistThumbnail extends StatelessWidget {
  final Playlist playlist;

  const PlaylistThumbnail({
    super.key,
    required this.playlist
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        CoverArt(height: 48, image: Music.getPlaylistCover(playlist).toString()),

        const SizedBox(width: 24),

        Flexible(
          flex: 1,
          fit: FlexFit.tight,

          child: Text(
            playlist.name ?? "",
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          )
        ),

        const SizedBox(width: 12),

        Text(
          playlist.songCount.toString(), 
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class PlaylistView extends StatelessWidget {
	final Playlist playlist;
	
  const PlaylistView({
    super.key,
		required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: playlist.songs!.length + 1,

      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              CoverArt(
                height: 144,
                image: Music.getPlaylistCover(playlist).toString()
              ),

              const SizedBox(height: 12,),
  
              Column(
                children: [
                  Text(
                    playlist.name ?? "", 
                    style: const TextStyle(fontSize: 18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ]
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  FilledButton(
                    onPressed: () async {
                      await PlayerModel.player.setShuffleModeEnabled(false);
                      await PlayerModel.instance.setPlaylist(playlist.songs!, index: 0);
                      await PlayerModel.player.play();
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
      
                  FilledButton(
                    onPressed: () async {
                      await PlayerModel.player.setShuffleModeEnabled(true);
                      await PlayerModel.instance.setPlaylist(playlist.songs!);
                      await PlayerModel.player.play();
                    },
                    child: const Icon(Icons.shuffle),
                  ),
                ]
              ),

              const SizedBox(height: 12),
            ]
          );
        }

        return InkWell(
          onTap: () async {
            await PlayerModel.instance.setPlaylist(playlist.songs!, index: index - 1);
            await PlayerModel.player.play();
          },

          child: TrackThumbnail(song: playlist.songs![index - 1], index: index)
        );
      },

      separatorBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const SizedBox(height: 12);
        }

        return const Divider();
      },   
    );
  }
}

class TrackThumbnail extends StatelessWidget {
  final Song song;
  final int index;

  const TrackThumbnail({
    super.key,
    required this.song,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        CoverArt(height: 36, image: Music.getSongCover(song).toString()),

        const SizedBox(width: 24),

        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                song.title ?? "",
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis
              ),

              Text(
                song.artist ?? "",
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Text(PlayerModel.secondsToString(song.duration ?? 0)),
      ],
    );
  }
}
