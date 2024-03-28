import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class CoverArt extends StatelessWidget {
  final int height;
  final String? image;

  const CoverArt({super.key, required this.height, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(height / 12),
        child: Stack(children: [
          Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: Icon(
                Icons.album,
                size: height.toDouble(),
                color: Theme.of(context).colorScheme.onSecondary,
              )),
          if (image != null)
            Image.network(
              image!,
              height: height.toDouble(),
            ),
        ]));
  }
}

class PlayingImage extends StatelessWidget {
  final int height;

  const PlayingImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerModel, String?>(
        selector: (_, playerModel) => playerModel.mediaItem?.artUri.toString(),
        builder: (context, image, child) {
          return CoverArt(height: height, image: image);
        });
  }
}
