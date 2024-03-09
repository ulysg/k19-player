import "package:flutter/material.dart";

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

          Slider(
            value: 0,
            onChanged: (i) {},
          ),
          
          const Text("Wow what a cool music"),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              FilledButton.tonal(
                onPressed: () {print("hello");},
                child: const Icon(Icons.skip_previous),
              ),

              FilledButton(
                onPressed: () {print("hello");},
                child: const Icon(Icons.play_arrow),
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
