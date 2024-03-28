import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/data/repositories/subsonic_repository.dart";
import "package:k19_player/domain/entities/album.dart";
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
		return Text(album.title ?? "");
  }
}
