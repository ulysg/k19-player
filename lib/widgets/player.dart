import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
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
              Selector<PlayerModel, String?>(
                selector: (_, playerModel) => playerModel.mediaItem?.title,

                builder: (context, title, child) {
                  return Text(
                    title ?? "",
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis
                  );
                }
              ),

              const SizedBox(height: 6),
                
              Selector<PlayerModel, String?>(
                selector: (_, playerModel) => playerModel.mediaItem?.artist,

                builder: (context, artist, child) {
                  return Text(
                    artist ?? "",
                    overflow: TextOverflow.ellipsis
                  );
                },
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Selector<PlayerModel, bool>(
                selector: (_, __) => PlayerModel.player.hasPrevious,

                builder: (context, hasPrevious, child) {
                  return FilledButton.tonal(
                    onPressed: hasPrevious ? () => PlayerModel.player.seekToPrevious() : null,

                    child: const Icon(Icons.skip_previous),
                  );
              }),

              Selector<PlayerModel, bool>(
                selector: (_, playerModel) => playerModel.playing,

                builder: (context, playing, child) {
                  IconData icon = playing ? Icons.pause : Icons.play_arrow; 

                  return FilledButton(
                    onPressed: () {
                      PlayerModel.player.playing ?  PlayerModel.player.pause() : PlayerModel.player.play();
                    },

                    child: Icon(icon)
                  );
                }
              ),

              Selector<PlayerModel, bool>(
                selector: (_, __) => PlayerModel.player.hasNext,

                builder: (context, hasNext, child) {
                  return FilledButton.tonal(
                    onPressed: hasNext ? () => PlayerModel.player.seekToNext() : null,

                    child: const Icon(Icons.skip_next),
                  );
              }),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Selector<PlayerModel, LoopMode>(
                selector: (_, __) => PlayerModel.player.loopMode,

                builder: (context, loopMode, child) {
                  if (loopMode == LoopMode.all) {
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

              Selector<PlayerModel, bool>(
                selector: (_, __) => PlayerModel.player.shuffleModeEnabled,

                builder: (context, shuffleModeEnabled, child) {
                  if (shuffleModeEnabled) {
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
    return Selector<PlayerModel, (int, int)>(
      selector: (_, playerModel) => (playerModel.position, playerModel.duration),

      builder: (context, positionDuration, child) {
        return Row(
          children: [
            Text(
              secondsToString(positionDuration.$1)
            ),

            Expanded(
              child: Slider(
                value: positionDuration.$1.toDouble(),
                max: positionDuration.$2.toDouble(),
                onChanged: (i) {
                  PlayerModel.instance.seek(i.toInt());
                },
              )
            ),

            Text(
              secondsToString(positionDuration.$2)
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