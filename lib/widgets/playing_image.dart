import "dart:io";

import "package:flutter/material.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class CoverArt extends StatelessWidget {
  final int size;
  final Future<Uri?> image;

  const CoverArt({super.key, required this.size, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 12),

      child: FutureBuilder(
        future: image,

        builder: (context, snapshot) {
          Widget icon = Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),

            child: Icon(
              Icons.album,
              size: size.toDouble(),
              color: Theme.of(context).colorScheme.onSecondary,
            )
          );

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null) {
                return icon;
              }
           
              return Image.file(
                height: size.toDouble(),
                width: size.toDouble(),
                fit: BoxFit.cover,
                File.fromUri(snapshot.data!)
              );

            default:
              return icon;
          }
        }
      )
    );
  }
}

class PlayingImage extends StatelessWidget {
  final int size;

  const PlayingImage({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerModel, MediaItem?>(
      selector: (_, playerModel) => playerModel.mediaItem,

      builder: (context, mediaItem, child) {
        if (mediaItem == null) {
          return CoverArt(
            size: size,
            image: Future(() => null)
          );
        }
        
        return CoverArt(
          size: size, 
          image: Music.instance.getSongCover(ContentModel.instance.getSong(mediaItem.id))
        );
      });
  }
}
