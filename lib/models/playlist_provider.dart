import 'package:audioplayers/audioplayers.dart';
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
        songName: "Tsara Tsara [Audio]",
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
    Song(
        songName: "Song essais",
        artistName: "Julio",
        imagePath: "assets/images/radio.png",
        audioPath: "song.mp3"
    ),

  ];
  //Current song index
  int? _currentSongIndex;

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider () {
    listenDuration();
  }

  bool _isPlaying = false;

  //play
  void play () async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));

    _isPlaying = true;
    notifyListeners();
  }

  //pause
  void pause () async {
    await _audioPlayer.stop();

    _isPlaying = false;
    notifyListeners();
  }

  //remettre
  void resume () async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.setSource(AssetSource(path));
    await _audioPlayer.resume();

    _isPlaying = true;
    notifyListeners();
  }

  //pause ou remettre
  void pauseOrResume () async {
    if (_isPlaying) {
      pause();
    }
    else {
      resume();
    }
    notifyListeners();
  }

  //position du Slider
  void seek (Duration position) async {
    await _audioPlayer.seek(position);
  }

  //next song
  void playNextSong () {
    if (_currentSongIndex != null) {
      // mettre en pause l'ancien song
      pause();

      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      }
      else {
        _currentSongIndex = 0;
      }
      // mettre sur play le nouveau song
      play();
    }
  }

  //previous song
  void playPreviousSong () async{

    if (_currentSongIndex != null) {
      // mettre en pause l'ancien song
      pause();
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      }
      else {
        _currentSongIndex = _playlist.length - 1;
      }
      // mettre sur play le nouveau song
      play();
    }
  }

  void listenDuration () {
    // total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //écouter la fin de la chanson
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });

  }


  //Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;



  //Setters
  set currentSongIndex(int? newIndex) {
    //mettre a jour l'index du song
    _currentSongIndex = newIndex;
    // if (newIndex != null) {
    //   play();
    // }

    //Update UI
    notifyListeners();
  }
  void updatePlaylist(List<Song> newSongs) {
    _playlist.clear();
    _playlist.addAll(newSongs);
    notifyListeners();
  }



}