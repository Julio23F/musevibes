import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
            children: [
              SizedBox(height: 25,),

              //Liste des playlist
              for(int i = 0; i<10; i++)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Color(0xff30314d),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      //Image représentant du playlist
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0), // Assure que l'image a les mêmes coins arrondis
                        child: Image.asset(
                          "assets/images/album.jpg",
                          width: 70,
                        ),
                      ),
                      SizedBox(width: 25,),

                      //Description du playlist
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auteur de la musique",
                              style: TextStyle(
                                  color: Colors.white70
                              ),
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.grey.shade200
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Icon play pause
                      Icon(
                        Icons.more_horiz_outlined,
                        size: 27,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ],
                  ),
                )
            ],
          )
      ),
    );
  }
}
