import "package:flutter/material.dart";
import "package:k19_player/models/player_model.dart";
import "package:k19_player/widgets/album_view.dart";
import "package:k19_player/widgets/player.dart";
import "package:k19_player/widgets/playing_image.dart";
import "package:provider/provider.dart";

class SmallPlayer extends StatelessWidget {
  const SmallPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            const PlayingImage(
              height: 48,
            ),

            const SizedBox(width: 12),

            Flexible(
              child: Column (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Selector<PlayerModel, String?>(
                    selector: (_, playerModel) => playerModel.mediaItem?.title,

                    builder: (context, title, child) {
                      return Text(
                        title ?? "",
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis
                      );
                    }
                  ),
                    
                  Selector<PlayerModel, String?>(
                    selector: (_, playerModel) => playerModel.mediaItem?.artist,

                    builder: (context, artist, child) {
                      return Text(
                        artist ?? "",
                        overflow: TextOverflow.ellipsis
                      );
                    },
                  )
                ]
              ),
            ),

            const SizedBox(width: 12),

            const PlayingButton()
          ]
        ),
      )
    );
  }
}

class SmallPlayerView extends StatelessWidget {
  final Widget child;
  final Widget? action;
  final String title;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  SmallPlayerView({
    required this.child,
    required this.title,
    this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onPanEnd: (details) {
        Offset offset = details.velocity.pixelsPerSecond;

        if (offset.dy < -5 && offset.dy.abs() > offset.dx.abs()) {
          Scaffold.of(context).showBottomSheet((builder) {
            return const Player();
          });
        }
      },

      child: Scaffold(
        body: NavigatorPopHandler(
          onPop: ()  => navigatorKey.currentState!.maybePop(),
          
          child: Navigator(
            key: navigatorKey,
            
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (context) {
                List<Widget> actions = [];

                if (action != null) {
                  actions.add(action!);
                }

                return Scaffold(
                  appBar: AppBar(
                    title: Text(title),

                    actions: actions,
                  ),

                  body: child,
                );
              }  
            )
          ),
        ),
        
        bottomNavigationBar: GestureDetector(
          behavior: HitTestBehavior.opaque,

          onTap: () {
            Scaffold.of(context).showBottomSheet((builder) {
              return const Player();
            });
          },

          child: const SmallPlayer(),
        ),
      )
    );
  }
}
