import "package:flutter/material.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
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

              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        height: 48,
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            song.title ?? "No Title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(song.album ?? "No Album"),
                        ]),
                    Consumer<PlayerModel>(
                        builder: (context, playerModel, child) {
                      IconData icon =
                          playerModel.playing ? Icons.pause : Icons.play_arrow;

                      return FilledButton(
                          onPressed: () {
                            PlayerModel.player.playing
                                ? PlayerModel.player.pause()
                                : PlayerModel.player.play();
                          },
                          child: Icon(icon));
                    }),
                  ]);
            }
          });
    });
  }
}
