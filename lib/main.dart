import 'package:flutter/material.dart';
import 'package:musevibes/models/playlist_provider.dart';
import 'package:musevibes/pages/startPage.dart';
import 'package:provider/provider.dart';

void main() {
    runApp(
        ChangeNotifierProvider(
          create: (context) => PlaylistProvider(),
          child: MyApp()
        ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MuseVibes',
      home: StartPage(),
    );
  }
}

