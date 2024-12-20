// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Constant.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';

class RankingPage extends StatefulWidget{
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPage();

}

class _RankingPage extends State<RankingPage>{
  

  @override 
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer2<GameInfoProvider,AccountInfoProvider>(
      builder: (context, gameInfoProvider, accountInfoProvider, child) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i = 1; i <= 3; i++)
                      Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black
                                )
                              ),
                              child: Image.asset('images/manIcon.png'),
                            ),
                            Text(
                              accountInfoProvider.username ,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '$i' ,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: [
                    for(int i = 1; i <= 10; i++)
                      Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black
                                )
                              ),
                              child: Image.asset('images/manIcon.png'),
                            ),
                            Text(
                              accountInfoProvider.username ,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '$i' ,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}