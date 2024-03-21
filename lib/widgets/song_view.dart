import "package:flutter/material.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:provider/provider.dart";

class SongView extends StatelessWidget {
  const SongView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, List<Song>>(
      selector: (_, contentModel) => contentModel.songs,

      builder: (context, songs, child) {
        return GridView.count(
          crossAxisCount: 3,

          children: songs.map(
            (song) => Text(
              song.title ?? ""
            )
          ).toList()
        );
      }
    );
  }
}