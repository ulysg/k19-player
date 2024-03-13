import "package:flutter/material.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class Player extends StatelessWidget {
  const Player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerModel>(builder: (context, playerModel, child) {
      return FutureBuilder<Song>(
          future: playerModel.actualSong(),
          builder: (context, futureResponse) {
            if (futureResponse.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (futureResponse.hasError || futureResponse.data == null) {
              return Text('Error: ${futureResponse.error}');
            } else {
              Song song = futureResponse.data!;

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
                    }),
                    Text(song.title ?? "No title"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            playerModel.start();
                          },
                          child: const Icon(Icons.skip_previous),
                        ),
                        Consumer<PlayerModel>(
                            builder: (context, playerModel, child) {
                          IconData icon = playerModel.playing
                              ? Icons.pause
                              : Icons.play_arrow;

                          return FilledButton(
                              onPressed: () {
                                PlayerModel.player.playing
                                    ? PlayerModel.player.pause()
                                    : PlayerModel.player.play();
                              },
                              child: Icon(icon));
                        }),
                        FilledButton.tonal(
                          onPressed: () {
                            playerModel.next();
                          },
                          child: const Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          });
    });
  }
}
