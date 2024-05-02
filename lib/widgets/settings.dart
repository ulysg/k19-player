import "dart:core";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/connection.dart";
import "package:k19_player/models/content_model.dart";
import "package:provider/provider.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  TextEditingController userController = TextEditingController(text: ContentModel.instance.connection?.username ?? "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController urlController = TextEditingController(text: ContentModel.instance.connection?.url ?? "");
  bool canConnect = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String title = ContentModel.instance.connectionSet ? AppLocalizations.of(context)!.settings : AppLocalizations.of(context)!.welcome;

    return Scaffold(
      appBar: AppBar(
        leading: ImageIcon(
          const AssetImage("assets/images/icon.png"),
          color: Theme.of(context).colorScheme.onBackground
        ),

        title: Text(title)
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            if (!ContentModel.instance.connectionSet) 
              Text(
                AppLocalizations.of(context)!.login,
                style: const TextStyle(fontSize: 18),
              ),

            if (!ContentModel.instance.connectionSet)
              const SizedBox(height: 24),
          
            TextField(
              controller: userController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.username,
                hintText: "username",
                border: const OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                hintText: "password",
                border: const OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.hostname,
                hintText: "https://exemple.com",
                border: const OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,

                        child: FilledButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await ContentModel.instance.setConnection(userController.text, passwordController.text, urlController.text);
                            bool result = await Music.instance.ping();

                            setState(() {
                              canConnect = result;
                              isLoading = false;
                            });
                          },

                          child: isLoading ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary))
                            : Text(AppLocalizations.of(context)!.check, textAlign: TextAlign.center),
                        ),
                      )
                    ),

                    const SizedBox(width: 24),

                    Expanded(
                      child: SizedBox(
                        height: 48,

                        child: FilledButton(
                          onPressed: canConnect ? () async {
                            await ContentModel.instance.setConnection(userController.text, passwordController.text, urlController.text);
                            await ContentModel.instance.getContent();
                          }
                            : null,

                          child: Text(AppLocalizations.of(context)!.save),
                        )
                      )
                    )
                  ],
                )
              ]
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,

                    child: FilledButton(
                      onPressed: () async {
                        await ContentModel.instance.refreshCache();
                      },

                      child: Selector<ContentModel, bool>(
                        selector: (_, contentModel) => contentModel.isLoading,

                        builder: (context, isLoading, child) => isLoading 
                          ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary))
                          : Text(AppLocalizations.of(context)!.sync)
                      ) 
                    )
                  )
                )
              ]
            )
          ],
        )
      )
    );
  }
} 
