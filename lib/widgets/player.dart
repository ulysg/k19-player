import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:k19_player/models/player_model.dart";
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
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            
            child: Image.network(
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            ),
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
          
          const Text("Wow what a cool music"),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              FilledButton.tonal(
                onPressed: () {
                  final audioSource = AudioSource.uri(
                    Uri.parse("https://samplelib.com/lib/preview/mp3/sample-15s.mp3"),
                    tag: MediaItem(
                      id: "1",
                      album: "Lol",
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
