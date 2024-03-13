import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/player.dart";
import "package:provider/provider.dart";

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Scaffold.of(context).showBottomSheet((builder) {
          return const Player();
         });
      },
                      
      child: BottomAppBar(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                
                child: Consumer<PlayerModel>(
                  builder: (context, playerModel, child) {
                    String? image = playerModel.mediaItem?.artUri.toString();

                    if (image != null) {
                      return Image.network(
                        image,
                        height: 48,
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary
                      ),
                      child: Icon(
                        Icons.album,
                        size: 48,
                        color: Theme.of(context).colorScheme.surface,
                      )
                    );
                  }
                ),
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
                      );
                    }
                  ),
                    
                  Consumer<PlayerModel>(
                    builder: (context, playerModel, child) {
                      return Text(
                        playerModel.mediaItem?.artist ?? "",
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
      ),
    );
  }
}