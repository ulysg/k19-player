import "package:dynamic_color/dynamic_color.dart";
import "package:flutter/material.dart";
import "package:k19_player/api/player.dart";
import "package:k19_player/widgets/small_player.dart";

import "widgets/player.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      PlayerProvider.player.setUrl("https://samplelib.com/lib/preview/mp3/sample-12s.mp3");
      PlayerProvider.player.play();

      return MaterialApp(
        theme: ThemeData(
          colorScheme: lightColorScheme,
        ),
        
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),

        home: Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.music_note),
                label: 'Playlists',
              ),
              NavigationDestination(
                icon: Icon(Icons.album),
                label: 'Albums',
              ),
            ],
          ),

          body: Scaffold(
            bottomNavigationBar: BottomAppBar(child: SmallPlayer(),),
            body: Player(),
          ),
        ),
      );
    });
  }
}
