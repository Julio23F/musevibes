import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    double containerWidth = halfScreenWidth - 50;
    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: ListView(
        padding: EdgeInsets.all(30),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.red,
                      child: Container(height: 30,width: containerWidth,)
                    ),
                    Container(
                      color: Colors.greenAccent,
                        child: Container(height: 40,width: containerWidth,)

                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff161616), Colors.yellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                                top: 0,
                                child: Container(
                                  width: 300,
                                  child: Lottie.asset(
                                    "assets/annimation/music.json",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ),
                            Container(
                                child: Image.asset(
                                  "assets/images/radio.png",
                                ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),

          SizedBox(height: 55,),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Listen to your",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25
                  ),
                ),
                Text(
                  "Favorite Music",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w500
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 25,),

          Container(
            child: Text(
              "Image",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}
