import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/player.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:provider/provider.dart";

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return BottomAppBar(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const PlayingImage(
                height: 48,
              ),

              const SizedBox(width: 12),

              Flexible(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Consumer<PlayerModel>(
                      builder: (context, playerModel, child) {
                        return Text(
                          playerModel.mediaItem?.title ?? "",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis
                        );
                      }
                    ),
                      
                    Consumer<PlayerModel>(
                      builder: (context, playerModel, child) {
                        return Text(
                          playerModel.mediaItem?.artist ?? "",
                          overflow: TextOverflow.ellipsis
                        );
                      },
                    )
                  ]
                ),
              ),

              const SizedBox(width: 12),

              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  IconData icon = playerModel.playing ? Icons.pause : Icons.play_arrow; 

                  return FilledButton(
                    onPressed: () {PlayerModel.player.playing ?  PlayerModel.player.pause() : PlayerModel.player.play();},
                    child: Icon(icon)
                  );
                }
              ),
            ]
          ),
        )
      );
  }
}

class SmallPlayerView extends StatelessWidget {
  final Widget child;

  const SmallPlayerView({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < 0) {
          Scaffold.of(context).showBottomSheet((builder) {
            return const Player();
          });
        }
      },

      child: Scaffold(
        body: child,

        bottomNavigationBar: GestureDetector(
          behavior: HitTestBehavior.opaque,

          onTap: () {
            Scaffold.of(context).showBottomSheet((builder) {
              return const Player();
            });
          },

          child: const SmallPlayer(),
        ),
      )
    );
  }
}
