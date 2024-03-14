import "package:flutter/material.dart";
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          const PlayingImage(
            height: 288,
          ),

          const MusicSlider(),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
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
              FilledButton.tonal(
                onPressed: () async {
                  List<Song> songs = await Music.instance.getRandomSongs();
                  PlayerModel.instance.setPlaylist(songs);
                },

                child: const Icon(Icons.skip_previous),
              ),

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

              FilledButton.tonal(
                onPressed: () {
                  PlayerModel.player.seekToNext();
                },

                child: const Icon(Icons.skip_next),
              ),
            ],
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