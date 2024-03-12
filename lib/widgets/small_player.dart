import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:provider/provider.dart";

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

        const Column (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Text(
              "WOW SUPER MUSIC",
              style: TextStyle(fontWeight: FontWeight.bold),),
              
            Text("Super autheur"),
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
    );
  }
}