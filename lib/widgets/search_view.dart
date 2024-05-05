
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/media.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/album_view.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:k19_player/widgets/playlist_view.dart";
import "package:k19_player/widgets/song_view.dart";
import "package:provider/provider.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SearchAnchor(
            builder: (context, controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
                shadowColor: const MaterialStatePropertyAll(Color(0x00ffffff)),
                onTap: () => controller.openView,
                onChanged: (s) => ContentModel.instance.search(s),
                onSubmitted: (s) => ContentModel.instance.search(s),
                leading: const Icon(Icons.search)
              );
            },

            suggestionsBuilder: (context, controller) {
              return List.empty();
            },
          )
        ),

        Expanded(
          child: Consumer<ContentModel>(
            builder: (context, contentModel, child) {
              return Scrollbar(
                thickness: 6,
                radius: const Radius.circular(6),
          
                child: ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: contentModel.searchResult.length,

                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await PlayerModel.instance.setPlaylist(contentModel.songs, index: index);
                        await PlayerModel.player.play();
                      },

                      child: SearchThumbnail(media: contentModel.searchResult[index])
                    );
                  },

                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              );
            }
          )
        )
      ]
    );
  }
}

class SearchThumbnail extends StatelessWidget {
  final Media media;

  const SearchThumbnail({
    super.key,
    required this.media
  });

  @override
  Widget build(BuildContext context) {
    if (media is Song) {
      return SongThumbnail(song: media as Song);
    }

    if (media is Album) {
      return AlbumThumbnail(album: media as Album);
    }

    return PlaylistThumbnail(playlist: media as Playlist);
  }
}
