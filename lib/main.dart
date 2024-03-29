import "package:dynamic_color/dynamic_color.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:k19_player/models/content_model.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/album_view.dart";
import "package:k19_player/widgets/small_player.dart";
import "package:k19_player/widgets/song_view.dart";
import "package:provider/provider.dart";

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: "k19_player",
    androidNotificationChannelName: "K-19 Player",
    androidNotificationOngoing: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  List<Song> songs = await Music.instance.getRandomSongs();
  ContentModel.instance.songs = songs;

  List<Album> albums = await Music.instance.getAlbums();
  ContentModel.instance.albums = albums;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerModel>(create: (_) => PlayerModel.instance),
        ChangeNotifierProvider<ContentModel>(create: (_) => ContentModel.instance),
      ],

      child: const MainApp(),
    )
  );
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

        home: const MainView()
      );
    });
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        selectedIndex: currentPageIndex,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.album),
            label: "Albums",
          ),

          NavigationDestination(
            icon: Icon(Icons.featured_play_list),
            label: "Playlists",
          ),
          
          NavigationDestination(
            icon: Icon(Icons.music_note),
            label: "Songs",
          ),
        ],
      ),

      body: [
        const SmallPlayerView(
          title: "Albums",
          child: AlbumView(),
        ),
        
        const SmallPlayerView(
          title: "Playlists",
          child: Text("Playlist"),
        ),

        const SmallPlayerView(
          title: "Songs",
          child: SongView(),
        ),
      ][currentPageIndex],
    );
  }
}

