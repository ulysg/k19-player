import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class CoverArt extends StatelessWidget {
  final int height;
  final Future<Uri?> image;

  const CoverArt({super.key, required this.height, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 12),

      child: FutureBuilder(
        future: image,

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Image.network(
                snapshot.data.toString()
              );

            default:
              return Icon(
                Icons.album,
                size: height.toDouble(),
                color: Theme.of(context).colorScheme.onSecondary,
              );
          }
        }
      )
    );
  }
}

class PlayingImage extends StatelessWidget {
  final int height;

  const PlayingImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerModel, Uri?>(
      selector: (_, playerModel) => playerModel.mediaItem?.artUri,

      builder: (context, image, child) {
        return CoverArt(height: height, image: Future(() => image));
      });
  }
}
