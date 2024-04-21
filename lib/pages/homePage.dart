import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musevibes/widgets/music.dart';
import 'package:musevibes/pages/musicPlayer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

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
  }

  late List<Song> _selectedFiles = [];


  void pickMultipleFiles () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom, allowedExtensions: ["mp3"]);
    if (result != null) {
      List<String> files = result.paths.map((path) => path!).toList();

      _selectedFiles = createSongsFromFiles(files);
      setState(() {
        _selectedFiles = _selectedFiles;
      });

      Provider.of<PlaylistProvider>(context, listen: false)
          .updatePlaylist(_selectedFiles);

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
  void goToSong (int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicPlayer())
    );
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
                              print("voici le chemin: ${_selectedFiles}");
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
                      "Hello Julio ${_selectedFiles}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _selectedFiles.length,
                        itemBuilder: (context, index) {
                          final Song song = _selectedFiles[index];
                          return InkWell(
                            onTap: () {
                              print("index: ${index}");
                              goToSong(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xff30314d),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Row(
                                children: [
                                  Text(
                                    (index+1).toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${song.artistName} - ${song.songName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          "Bass - 04:30",
                                          style: TextStyle(
                                              color: Colors.white.withOpacity(0.8)
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 25,
                                      color: Color(0xff31314f),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }

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
                        Tab(child: Text('Favourites'),),
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
                          MusicList(),
                          MusicList(),
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
