import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
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

              Column (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,

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