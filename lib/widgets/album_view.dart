import "package:flutter/material.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:provider/provider.dart";

class AlbumView extends StatelessWidget {
  const AlbumView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, List<Album>>(
      selector: (_, contentModel) => contentModel.albums,

      builder: (context, albums, child) {
        return GridView.count(
          crossAxisCount: 3,

          children: albums.map(
            (album) => Text(
              album.title ?? ""
            )
          ).toList()
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
        const CoverArt(height: 48),

        Text(album.title ?? ""),
      ],
    );
  }
}