import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:provider/provider.dart";

class Player extends StatelessWidget {
  const Player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          const SizedBox(height: 0),

          const PlayingImage(
            height: 288,
          ),

          const MusicSlider(),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return Text(
                    playerModel.mediaItem?.title ?? "",
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis
                  );
                }
              ),

              const SizedBox(height: 6),
                
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return Text(
                    playerModel.mediaItem?.artist ?? "",
                    overflow: TextOverflow.ellipsis
                  );
                },
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return FilledButton.tonal(
                    onPressed: PlayerModel.player.hasPrevious ? () => PlayerModel.player.seekToPrevious() : null,

                    child: const Icon(Icons.skip_previous),
                  );
              }),

              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  IconData icon = playerModel.playing ? Icons.pause : Icons.play_arrow; 

                  return FilledButton(
                    onPressed: () {
                      PlayerModel.player.playing ?  PlayerModel.player.pause() : PlayerModel.player.play();
                    },

                    child: Icon(icon)
                  );
                }
              ),

              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return FilledButton.tonal(
                    onPressed: PlayerModel.player.hasNext ? () => PlayerModel.player.seekToNext() : null,

                    child: const Icon(Icons.skip_next),
                  );
              }),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  if (PlayerModel.player.loopMode == LoopMode.all) {
                    return IconButton.filled(
                      onPressed: () {
                        PlayerModel.player.setLoopMode(LoopMode.off);
                      },

                      icon: const Icon(Icons.loop),
                    );
                  }

                  return IconButton(
                      onPressed: () {
                        PlayerModel.player.setLoopMode(LoopMode.all);
                      },

                      icon: const Icon(Icons.loop),
                    );
                }
              ),

              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  if (PlayerModel.player.shuffleModeEnabled) {
                    return IconButton.filled(
                      onPressed: () {
                        PlayerModel.player.setShuffleModeEnabled(false);
                      },

                      icon: const Icon(Icons.shuffle),
                    );
                  }

                  return IconButton(
                      onPressed: () {
                        PlayerModel.player.setShuffleModeEnabled(true);
                      },

                      icon: const Icon(Icons.shuffle),
                    );
                }
              )
            ]
          ),
        ],
      ),
    );
  }
}

class MusicSlider extends StatelessWidget {
  const MusicSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerModel>(
      builder: (context, playerModel, child) {
        return Row(
          children: [  
            Text(
              secondsToString(playerModel.position)
            ),

            Expanded(
              child: Slider(
                value: playerModel.position.toDouble(),
                max: playerModel.duration.toDouble(),
                onChanged: (i) {
                  playerModel.seek(i.toInt());
                },
              )
            ),

            Text(
              secondsToString(playerModel.duration)
            ),
          ],
        );
      }
    );
  }

  secondsToString(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String m = duration.inMinutes.remainder(60).toString();
    String s = duration.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$m:$s";
  }
}