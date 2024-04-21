import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musevibes/pages/homePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var isFinished = false;

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    double containerWidth = halfScreenWidth - 50;
    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: Stack(

        children: [

          //Faire le fond de la page
          Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 200,
              left: 100,
              child: Image.asset("assets/images/Spline.png")
          ),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20,sigmaY: 10),
              )
          ),
          RiveAnimation.asset("assets/rive/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 35,sigmaY: 30),
                child: SizedBox(),
              )
          ),


          //Les élément devant
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
                child: Column(
                  children: [
                    //Image radio
                    Container(
                        child:Column(
                          children: [
                              SizedBox(
                                height: 50
                              ),
                              SizedBox(
                                height: 150,
                                width: 250,
                                child: RiveAnimation.asset("assets/rive/music.riv"),
                              ),
                              SizedBox(
                                height: 150,
                                width: MediaQuery.of(context).size.width * (5/6),
                                child: RiveAnimation.asset(
                                  "assets/rive/musique.riv",
                                ),
                              ),
                              SizedBox(
                                  height: 55
                              ),

                              // Image.asset(
                              //     "assets/images/radio.png",
                              //     width: MediaQuery.of(context).size.width * (4/5),
                              // ),
                            ],
                        )
                    ),

                    //Text listen your favorite music
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Listen to your",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20
                            ),
                          ),
                          Text(
                            "Favorite Music",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 52,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                letterSpacing: 4
                            ),
                          ),


                        ],
                      ),
                    ),

                    Spacer(),

                    // Swipe
                    Container(
                        child: SwipeableButtonView(
                          buttonText: 'Start Playing',
                          buttontextstyle: TextStyle(fontSize: 15, color: Colors.orange),
                          buttonWidget: Container(
                            child: Text(
                              'Play',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          buttonColor: Color(0xfffbd013),
                          activeColor: Color(0xff282828),

                          isFinished: isFinished,
                          onWaitingProcess: () {
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                isFinished = true;
                              });
                            });
                          },
                          onFinish: () async {
                            await Navigator.push(context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: HomePage(),
                              ),
                            );

                            setState(() {
                              isFinished = false;
                            });
                          },
                        ),


                    ),
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
}
