import "dart:core";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/connection.dart";
import "package:k19_player/models/content_model.dart";
import "package:provider/provider.dart";

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
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: "Username",
                hintText: "username",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "password",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "Server URL",
                hintText: "https://exemple.com",
                border: OutlineInputBorder()
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

                            await ContentModel.instance.setConnection(urlController.text, userController.text, passwordController.text);
                            bool result = await Music.instance.ping();

                            setState(() {
                              canConnect = result;
                              isLoading = false;
                            });
                          },

                          child: isLoading ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
                            : const Text("Check connection", textAlign: TextAlign.center),
                        ),
                      )
                    ),

                    const SizedBox(width: 24),

                    Expanded(
                      child: SizedBox(
                        height: 48,

                        child: FilledButton(
                          onPressed: canConnect ? () async {
                            await ContentModel.instance.setConnection(urlController.text, userController.text, passwordController.text);
                            await ContentModel.instance.getContent();
                          }
                            : null,

                          child: const Text("Save"),
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

                        builder: (context, isLoading, child) => isLoading ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
                          : const Text("Sync database")
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
