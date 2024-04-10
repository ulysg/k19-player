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
          padding: const EdgeInsets.all(24),
          itemCount: albums.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 12),

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
                          title: Text(albums[index].name ?? "")
                        ),

                        body: Padding(
                          padding: const EdgeInsets.all(24),

                          child: AlbumView(album: albums[index])
                        )
                      );
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
          album.name ?? "",
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
     return ListView.separated(
      itemCount: album.songs!.length + 1,

      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              CoverArt(
                height: 144,
                image: Music.getAlbumCover(album).toString()
              ),

              const SizedBox(height: 12,),
  
              Column(
                children: [
                  Text(
                    album.name ?? "", 
                    style: const TextStyle(fontSize: 18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    album.artist ?? "",
                    maxLines: 1,
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
                      await PlayerModel.instance.setPlaylist(album.songs!, index: 0);
                      await PlayerModel.player.play();
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
      
                  FilledButton(
                    onPressed: () async {
                      await PlayerModel.player.setShuffleModeEnabled(true);
                      await PlayerModel.instance.setPlaylist(album.songs!);
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
            await PlayerModel.instance.setPlaylist(album.songs!, index: index - 1);
            await PlayerModel.player.play();
          },

          child: TrackThumbnail(song: album.songs![index - 1], index: index)
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
