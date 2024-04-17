import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/musicPlayer.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15,),
          for (int i=1; i<=10; i++)
          InkWell(
            onTap: () {
              Navigator.push(context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: MusicPlayer(),
                  )
              );
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
                      i.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                  SizedBox(width: 25,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Imagine Dragon - Beliver",
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
                  Spacer(),
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
          ),
        ],
      ),
    );
  }
}

