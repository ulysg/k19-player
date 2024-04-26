import "dart:core";
import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  String user = "";
  String password = "";
  String hostname = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            TextField(
              onChanged: (s) {
                setState(() {
                  user = s;
                });
              },

              decoration: const InputDecoration(
                labelText: "Username",
                hintText: "username",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              onChanged: (s) {
                setState(() {
                  password = s;
                });
              },

              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "password",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              onChanged: (s) {
                setState(() {
                  hostname = s;
                });
              },

              decoration: const InputDecoration(
                labelText: "Server hostname",
                hintText: "https://exemple.com",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                SizedBox(
                  height: 48,
                    child: FilledButton(
                    child: const Text("Check connection"),
                    onPressed: () => print("lol"),
                  ),
                ),

                const SizedBox(width: 24),

                SizedBox(
                  height: 48,
                  child: FilledButton(
                    child: const Text("Save"),
                    onPressed: () => Music.instance.setActualConnection(user, password, hostname),
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
} 
