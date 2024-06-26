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
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PlaylistList extends StatelessWidget {
  const PlaylistList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentModel>(
      builder: (context, contentModel, child) {
        return Scrollbar(
          thickness: 6,
          radius: const Radius.circular(6),

          child: ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: contentModel.playlists.length,

            itemBuilder: (context, index) {
                return PlaylistThumbnail(playlist: contentModel.playlists[index]);
            },

            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: () async {
        Navigator.push(
          context,
      
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(playlist.name ?? "")
                ),

                body: Padding(
                  padding: const EdgeInsets.all(24),

                  child: PlaylistView(playlist: playlist)
                )
              );
            }
          )
        );
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          CoverArt(
            size: 48,
            image: Music.instance.getPlaylistCover(playlist)
          ),

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
      )
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
      itemCount: playlist.song.length + 1,

      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              CoverArt(
                size: 144,
                image: Music.instance.getPlaylistCover(playlist)
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
                      await PlayerModel.instance.setPlaylist(playlist.song, index: 0);
                      await PlayerModel.player.play();
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
      
                  FilledButton(
                    onPressed: () async {
                      await PlayerModel.player.setShuffleModeEnabled(true);
                      await PlayerModel.instance.setPlaylist(playlist.song);
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
            await PlayerModel.instance.setPlaylist(playlist.song, index: index - 1);
            await PlayerModel.player.play();
          },

          child: TrackThumbnail(song: playlist.song[index - 1], index: index)
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
        CoverArt(
          size: 36, 
          image: Music.instance.getSongCover(song)
        ),

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

class PlaylistDropdown extends StatelessWidget {
  const PlaylistDropdown({
    super.key,
  });

  String getLabel(PlaylistSortOrder order, BuildContext context) {
    switch (order) {
      case PlaylistSortOrder.random:
        return AppLocalizations.of(context)!.random;

      case PlaylistSortOrder.nameAsc:
        return "${AppLocalizations.of(context)!.name} ↑";

      case PlaylistSortOrder.nameDesc:
        return "${AppLocalizations.of(context)!.name} ↓";

      case PlaylistSortOrder.countAsc:
        return "${AppLocalizations.of(context)!.songCount} ↑";

      case PlaylistSortOrder.countDesc:
        return "${AppLocalizations.of(context)!.songCount} ↓";

      case PlaylistSortOrder.yearAsc:
        return "${AppLocalizations.of(context)!.created} ↑";

      case PlaylistSortOrder.yearDesc:
        return "${AppLocalizations.of(context)!.created} ↓";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, PlaylistSortOrder>(
      selector: (_, contentModel) => contentModel.playlistsOrder,

      builder: (context, playlistsOrder, child) {
        return DropdownMenu<PlaylistSortOrder>(
          width: 120,
          initialSelection: playlistsOrder,

          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none
          ),

          onSelected: (sortOrder) {
            ContentModel.instance.changePlaylistsOrder(sortOrder!);
          },

          dropdownMenuEntries: PlaylistSortOrder.values.map((value) {
            return DropdownMenuEntry(
              value: value,
              label: getLabel(value, context),
            );
          }).toList(),
        );
      }
    );
  }
}
