import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musevibes/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}


class _MusicPlayerState extends State<MusicPlayer> {

  String formatTime (Duration duration) {
    String formatSeconde = duration.inSeconds.remainder(60).toString();
    String formatTime = "${duration.inMinutes}:${formatSeconde}";

    return formatTime;
  }

  String formatText (String text) {
    String newFormat = "";
    if (text.length > 14) {
      newFormat = '';
    }
    return newFormat;
  }

  @override
  Widget build(BuildContext context) {

    //Le Consumer est entouré par ChangeNotifierProvider dans main
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final playlist = value.playlist;

          final currentSong = playlist[value.currentSongIndex ?? 0];
          return Scaffold(
            body: Stack(
              children: [
                // Fond de la page
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff03224c),
                            Color(0xff0d1239),
                          ]
                      )
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    height: MediaQuery.of(context).size.width * (3/4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff05630),
                          Color(0xfff0c22d),
                        ],
                      ),
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 27,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text(
                          "Now Playing",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.queue_music_rounded,
                            size: 27,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //Représentation
                Positioned(
                  top: MediaQuery.of(context).size.width * (4/14),
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * (3/4),
                          width: MediaQuery.of(context).size.width * (3/4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 5, color: Color(0xfff7ad61)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xfff05630),
                                  Color(0xfff0c22d),
                                ]
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 15,
                                offset: Offset(0, 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              Text(currentSong.songName,
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white.withOpacity(0.8)
                                ),
                              ),
                              Text("Song by ${currentSong.artistName}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.4)
                                ),
                              ),

                              SizedBox(height: 25,),
                              //Chrono
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatTime(value.currentDuration),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(0.8)
                                      ),
                                    ),
                                    Text(
                                      formatTime(value.totalDuration),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(0.8)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Barre de progression
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 7
                                    )
                                ),
                                child: Slider(
                                    min: 0,
                                    max: value.totalDuration.inSeconds.toDouble(),
                                    value: value.currentDuration.inSeconds.toDouble(),
                                    onChanged: (double double) {

                                    },
                                    onChangeEnd: (double double) {
                                      value.seek(Duration(seconds: double.toInt()));
                                    },
                                ),
                              ),

                              //Bouton de controle
                              SizedBox(height: 35,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                      onTap: value.playPreviousSong,
                                      child: Icon(Icons.skip_previous, size: 45, color: Colors.white.withOpacity(0.8))
                                  ),
                                  GestureDetector(
                                    onTap: value.pauseOrResume,
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                            value.isPlaying ? Icons.pause : Icons.play_arrow,
                                            size: 45,
                                            color: Colors.white.withOpacity(0.8)
                                        )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      value.playNextSong();
                                    },
                                      child: Icon(Icons.skip_next, size: 45, color: Colors.white.withOpacity(0.8))
                                  ),
                                ],
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    // Création d'un path
    Path path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(
        w * 0.5,
        h - 100,
        w,
        h
    );
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
