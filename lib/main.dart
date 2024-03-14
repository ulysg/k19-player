import "package:dynamic_color/dynamic_color.dart";
import "package:flutter/material.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/small_player.dart";
import "package:provider/provider.dart";

import "widgets/player.dart";

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: false,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => PlayerModel(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: lightColorScheme,
        ),
        
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),

        home: const Scaffold(
          bottomNavigationBar: NavBar(),
          body: MainView()
        ),
      );
    });
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Player(),

      bottomNavigationBar: InkWell(
        onTap: () {
          Scaffold.of(context).showBottomSheet((builder) {
            return const Player();
          });
        },

        child: const SmallPlayer(),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

    @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
    );
  }
}
