import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
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

          //Représentation
          Positioned(
            top: MediaQuery.of(context).size.width * (2/8),
            right: 0,
            left: 0,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * (3/4),
                    width: MediaQuery.of(context).size.width * (3/4),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(150),
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
                          color: Colors.orange.withOpacity(0.2), // Couleur de l'ombre orange
                          spreadRadius: 4,
                          blurRadius: 15,
                          offset: Offset(0, 15), // Décalage de l'ombre
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Text('Count My Blessing',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white.withOpacity(0.8)
                          ),
                        ),
                        Text('Song by Enisa',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.4)
                          ),
                        ),

                        //Barre de progression


                        //Bouton de controle
                        SizedBox(height: 55,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.skip_previous, size: 45, color: Colors.white.withOpacity(0.8)),
                            Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(g
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(150)
                                ),
                                child: Icon(
                                    Icons.play_arrow, 
                                    size: 45,
                                    color: Colors.white.withOpacity(0.8)
                                )
                            ),
                            Icon(Icons.skip_next, size: 45, color: Colors.white.withOpacity(0.8)),
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
