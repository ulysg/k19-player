import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/playing_image.dart";
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
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: songs.length,

          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await PlayerModel.instance.setPlaylist(songs.skip(index).toList());
              },

              child: SongThumbnail(song: songs[index])
            );
          },

          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }
    );
  }
}

class SongThumbnail extends StatelessWidget {
  final Song song;

  const SongThumbnail({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        CoverArt(height: 48, image: Music.getCoverUri(song).toString()),

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