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

class PlaylistGrid extends StatelessWidget {
  const PlaylistGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, List<Playlist>>(
      selector: (_, contentModel) => contentModel.playlists,

      builder: (context, playlists, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: playlists.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 12),

          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                
                  MaterialPageRoute(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(24),

                        child: PlaylistView(playlist: playlists[index])
                      );
                    }
                  )
                );
              },

              child: PlaylistThumbnail(playlist: playlists[index])
            );
          },
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
    return Column(
      children: [
        CoverArt(
          height: 96,
          image: Music.getPlaylistCover(playlist).toString(),
        ),
        
        const SizedBox(height: 6),

        Text(
          playlist.name ?? "",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16)
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
                await PlayerModel.instance.setPlaylist(playlist.songs!, index: 0);
                await PlayerModel.player.setShuffleModeEnabled(false);
                await PlayerModel.player.play();
              },
              child: const Icon(Icons.play_arrow),
            ),
            
            FilledButton(
              onPressed: () async {
                await PlayerModel.instance.setPlaylist(playlist.songs!);
                await PlayerModel.player.setShuffleModeEnabled(true);
                await PlayerModel.player.play();
              },
              child: const Icon(Icons.shuffle),
            ),
          ]
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: playlist.songs!.length,

            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await PlayerModel.instance.setPlaylist(playlist.songs!, index: index);
                  await PlayerModel.player.play();
                },

                child: TrackThumbnail(song: playlist.songs![index], index: index + 1)
              );
            },

            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
        )
      ],
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
        Text(index.toString()),

        const SizedBox(width: 24),

        Flexible(
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
      ],
    );
  }
}
