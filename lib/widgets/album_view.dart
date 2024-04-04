import "dart:ffi";

import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/data/repositories/subsonic_repository.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:k19_player/widgets/small_player.dart";
import "package:provider/provider.dart";

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, List<Album>>(
      selector: (_, contentModel) => contentModel.albums,

      builder: (context, albums, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: albums.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 12),

          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                
                  MaterialPageRoute(
                    builder: (context) {
                      return AlbumView(album: albums[index]);
                    }
                  )
                );
              },

              child: AlbumThumbnail(album: albums[index])
            );
          },
        );
      }
    );
  }
}

class AlbumThumbnail extends StatelessWidget {
  final Album album;

  const AlbumThumbnail({
    super.key,
    required this.album
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoverArt(
          height: 96,
          image: Music.getAlbumCover(album).toString(),
        ),
        
        const SizedBox(height: 6),

        Text(
          album.title ?? "",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16)
        ),

        Text(
          album.artist ?? "",
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class AlbumView extends StatelessWidget {
	final Album album;
	
  const AlbumView({
    super.key,
		required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        CoverArt(
            height: 144,
            image: Music.getAlbumCover(album).toString()
          ),
        
    		Text(
          album.title ?? "", 
          style: const TextStyle(fontSize: 18)
        ),

        Text(
          album.artist ?? ""
        ),

        SizedBox(
          height: 240,

          child: ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: album.songs!.length,

            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await PlayerModel.instance.setPlaylist(album.songs!, index: index);
                  await PlayerModel.player.play();
                },

                child: TrackThumbnail(song: album.songs![index], index: index + 1)
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
