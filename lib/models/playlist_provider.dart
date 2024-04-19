import 'package:flutter/cupertino.dart';
import 'package:musevibes/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Jaloux (Clip Officiel)",
        artistName: "DADJU",
        imagePath: "assets/images/radio.png",
        audioPath: "songs/DADJU - Jaloux (Clip Officiel).mp3"
    ),
    Song(
        songName: "Tsara Tsara [Audio].mp3",
        artistName: "Denise Feat Jaojoby",
        imagePath: "assets/images/radio.png",
        audioPath: "songs/Denise Feat Jaojoby - Tsara Tsara [Audio].mp3"
    ),
    Song(
        songName: "I Will Be There",
        artistName: "Kalash",
        imagePath: "assets/images/radio.png",
        audioPath: "Kalash - I Will Be There.mp3"
    ),

  ];
  //Current song index
  int? _currentSongIndex;

  //Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  //Setters
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    //Update UI
    notifyListeners();
  }



}