import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musevibes/widgets/music.dart';
import 'package:file_picker/file_picker.dart';
import 'package:musevibes/widgets/online.dart';
import 'package:musevibes/widgets/playlist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/playlist_provider.dart';
import '../models/song.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState () {
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context,listen: false);

        // Initialisation des SharedPreferences au chargement du widget
    initSharedPreferences();

  }

  late List<Song> _selectedFiles = [];


  void pickMultipleFiles () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom, allowedExtensions: ["mp3"]);
    if (result != null) {
      List<String> files = result.paths.map((path) => path!).toList();

      _selectedFiles = createSongsFromFiles(files);


      //Mettre à jour la liste des playlist
      Provider.of<PlaylistProvider>(context, listen: false)
          .updatePlaylist(_selectedFiles);

      saveData(_selectedFiles);

    }
  }

  List<Song> createSongsFromFiles(List<String> audioPaths) {
    List<Song> songs = [];

    for (String audioPath in audioPaths) {
      String songName = audioPath.split('/').last.split('.').first;
      String artistName = audioPath.split('/').reversed.toList()[1];
      String imagePath = audioPath;

      songs.add(Song(
        songName: songName,
        artistName: artistName,
        imagePath: imagePath,
        audioPath: audioPath,
      ));
    }

    return songs;
  }

  List myData = [];

  // Initialisation des SharedPreferences
  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Récupération de la donnée depuis SharedPreferences
    setState(() {
      myData = prefs.getStringList('items') ?? [];
    });
  }

  // Sauvegarde de la donnée dans SharedPreferences
  Future<void> saveData(newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', newData);
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff303151).withOpacity(0.6),
                Color(0xff303151).withOpacity(0.9),
              ]
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // pickDirectory();
                            },
                            child: Icon(
                              Icons.sort_rounded,
                              color: Color(0xff899ccf),
                              size: 30,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              pickMultipleFiles();
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: Color(0xff899ccf),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(height: 30,),

                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Hello Julio ${myData}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "What you want to hear sir",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                      ),
                    ),
                  ),

                  //Barre de recherche
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      child: Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                          color: Color(0xff31354f),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search the music",
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)
                                  ),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                            )
                          ],
                        ),
                      ),
                  ),

                  //Liste des choix
                  Container(
                    child: TabBar(
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 18),
                      indicator: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 3,
                                  color: Color(0xff889ccf)
                              )
                          )
                      ),
                      tabs: [
                        Tab(child: Text('Musics'),),
                        Tab(child: Text('Playlists'),),
                        Tab(child: Text('Online'),),
                        Tab(child: Text('Trending'),),
                        Tab(child: Text('Collections'),),
                        Tab(child: Text('New'),),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                      child: TabBarView(
                        children: [
                          MusicList(),
                          PlayList(),
                          Online(),
                          MusicList(),
                          MusicList(),
                          MusicList(),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
