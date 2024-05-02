import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:provider/provider.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentModel>(
      builder: (context, contentModel, child) {
        return Scrollbar(
          thickness: 12,
          radius: const Radius.circular(12),

          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: contentModel.albums.length,
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
                            title: Text(contentModel.albums[index].name ?? "")
                          ),

                          body: Padding(
                            padding: const EdgeInsets.all(24),

                            child: AlbumView(album: contentModel.albums[index])
                          )
                        );
                      }
                    )
                  );
                },

                child: AlbumThumbnail(album: contentModel.albums[index])
              );
            },
          )
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
          size: 96,
          image: Music.instance.getAlbumCover(album)
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
      itemCount: album.song.length + 1,

      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              CoverArt(
                size: 144,
                image: Music.instance.getAlbumCover(album)
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
                      await PlayerModel.instance.setPlaylist(album.song, index: 0);
                      await PlayerModel.player.play();
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
      
                  FilledButton(
                    onPressed: () async {
                      await PlayerModel.player.setShuffleModeEnabled(true);
                      await PlayerModel.instance.setPlaylist(album.song);
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
            await PlayerModel.instance.setPlaylist(album.song, index: index - 1);
            await PlayerModel.player.play();
          },

          child: TrackThumbnail(song: album.song[index - 1], index: index)
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

class AlbumDropdown extends StatelessWidget {
  const AlbumDropdown({
    super.key,
  });

  String getLabel(SortOrder order, BuildContext context) {
    switch (order) {
      case SortOrder.random:
        return AppLocalizations.of(context)!.random;

      case SortOrder.nameAsc:
        return "${AppLocalizations.of(context)!.name} ↑";

      case SortOrder.nameDesc:
        return "${AppLocalizations.of(context)!.name} ↓";

      case SortOrder.artistAsc:
        return "${AppLocalizations.of(context)!.artist} ↑";

      case SortOrder.artistDesc:
        return "${AppLocalizations.of(context)!.artist} ↓";

      case SortOrder.yearAsc:
        return "${AppLocalizations.of(context)!.year} ↑";

      case SortOrder.yearDesc:
        return "${AppLocalizations.of(context)!.year} ↓";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ContentModel, SortOrder>(
      selector: (_, contentModel) => contentModel.albumsOrder,

      builder: (context, albumsOrder, child) {
        return DropdownMenu<SortOrder>(
          width: 132,
          initialSelection: albumsOrder,

          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none
          ),

          onSelected: (sortOrder) {
            ContentModel.instance.changeAlbumsOrder(sortOrder!);
          },

          dropdownMenuEntries: SortOrder.values.map((value) {
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
