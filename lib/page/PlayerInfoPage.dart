// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';

class PlayerInfoPage extends StatefulWidget{
  const PlayerInfoPage({super.key});

  @override
  State<PlayerInfoPage> createState() => _PlayerInfoPage();
}

class _PlayerInfoPage extends State<PlayerInfoPage>{
  

  @override 
  void initState() { 
    super.initState(); 
  }
  
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer<GameInfoProvider>(
      builder: (context, gameInfoProvider, child) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          
          title: Center( child: Text('球員資訊', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Center(
                      child: Image.network(gameInfoProvider.gameInfo[index]['home_team_icon'], height: 70, width: 70),
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Image.network(gameInfoProvider.gameInfo[index]['away_team_icon'], height: 80, width: 80),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for(int i = 0; i < max(gameInfoProvider.homePlayerInfo.length,gameInfoProvider.awayPlayerInfo.length); i++)
                  Row(
                    children: [
                      Flexible(
                        child: (i < gameInfoProvider.homePlayerInfo.length)?
                        Center(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: GestureDetector(
                                      child: Image.network(
                                        Uri.encodeFull(gameInfoProvider.homePlayerInfo[i]['icon']),
                                        width: 50, 
                                        height: 50,
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { return Image.network('https://www.cpbl.com.tw/theme/client/images/player_no_img.jpg', width: 100, height: 100); },
                                      ),
                                      onTap: (){
                                        gameInfoProvider.getSinglePlayerInfo(context, index,gameInfoProvider.homePlayerInfo[i] , true);
                                      },
                                    ),
                                  )
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.homePlayerInfo[i]['name'].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(child: 
                                          Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.homePlayerInfo[i]['position'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(child:
                                          Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.homePlayerInfo[i]['number'].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: SizedBox(
                            height: 50,
                          ),
                        ),
                      ),
                      Flexible(
                        child: (i < gameInfoProvider.awayPlayerInfo.length)?
                        Center(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.awayPlayerInfo[i]['number'].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ), 
                                        ),
                                        Flexible(
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.awayPlayerInfo[i]['position'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              gameInfoProvider.awayPlayerInfo[i]['name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: GestureDetector(
                                      child: Image.network(
                                        Uri.encodeFull(gameInfoProvider.awayPlayerInfo[i]['icon']),
                                        width: 50,
                                        height: 50,
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                          return Image.network('https://www.cpbl.com.tw/theme/client/images/player_no_img.jpg', width: 50, height: 50);
                                        },
                                      ),
                                      onTap: (){
                                        gameInfoProvider.getSinglePlayerInfo(context, index,gameInfoProvider.awayPlayerInfo[i] , false);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: SizedBox(
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}