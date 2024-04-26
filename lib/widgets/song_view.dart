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
    return Consumer<ContentModel>(
      builder: (context, contentModel, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: contentModel.songs.length,

          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await PlayerModel.instance.setPlaylist(contentModel.songs, index: index);
                await PlayerModel.player.play();
              },

              child: SongThumbnail(song: contentModel.songs[index])
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        CoverArt(height: 48, image: Music.instance.getSongCover(song).toString()),

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

class SongDropdown extends StatelessWidget {
  const SongDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, SortOrder>(
      selector: (_, contentModel) => contentModel.songsOrder,

      builder: (context, songsOrder, child) {
        return DropdownMenu<SortOrder>(
          width: 120,
          initialSelection: songsOrder,

          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none
          ),

          onSelected: (sortOrder) {
            ContentModel.instance.changeSongsOrder(sortOrder!);
          },

          dropdownMenuEntries: SortOrder.values.map((value) {
            return DropdownMenuEntry(
              value: value,
              label: value.label,
            );
          }).toList(),
        );
      }
    );
  }
}
