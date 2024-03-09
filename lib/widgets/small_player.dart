import "package:flutter/material.dart";

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

        FilledButton(
          onPressed: () {print("hello");},
          child: const Icon(Icons.play_arrow),
        ),
      ]
    );
  }
}