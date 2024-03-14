import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
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

          Consumer<PlayerModel>(
            builder: (context, playerModel, child) {
              return Slider(
                value: playerModel.position.toDouble(),
                max: playerModel.duration.toDouble(),
                onChanged: (i) {
                  playerModel.seek(i.toInt());
                },
              );
            }
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return Text(
                    playerModel.mediaItem?.title ?? "",
                    style: const TextStyle(fontSize: 18),
                  );
                }
              ),
                
              Consumer<PlayerModel>(
                builder: (context, playerModel, child) {
                  return Text(
                    playerModel.mediaItem?.artist ?? "",
                  );
                },
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              FilledButton.tonal(
                onPressed: () {
                  final audioSource = AudioSource.uri(
                    Uri.parse("https://music.ulys.ch/rest/stream?u=ulys&t=097830c0baef49605a1e25b80b122142&s=37237f05325738d00be2597a49ee1de3&v=1.16.1&c=ch.ulys.Periscope&f=json&id=bf12b2adfe6a7c66f805fd86bf1967e3"),
                    tag: MediaItem(
                      id: "1",
                      artist: "Lol",
                      title: "Super musique omg",
                      artUri: Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                    ),
                  );

                  PlayerModel.player.setAudioSource(audioSource);
                },
                child: const Icon(Icons.skip_previous),
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

              FilledButton.tonal(
                onPressed: () {print("hello");},
                child: const Icon(Icons.skip_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
