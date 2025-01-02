// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:software_project/page/RankingPage.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';
import 'package:software_project/provider/RankingProvider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer3<AccountInfoProvider, GameInfoProvider, RankingProvider>(
      builder: (context, accountInfoProvider, gameInfoProvider, rankingProvider,child) =>
      Scaffold(
        drawer: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: SizedBox(
              width: 200,
              height: 300,
              child: Drawer(
                child: ListView(
                  children: [
                    TextButton(
                      onPressed: ()async{
                        Navigator.pop(context);
                        await rankingProvider.initRanking();
                        Navigator.pushNamed(context,'/ranking');
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(200, 50)
                      ),
                      child: Text(
                        'Ranking',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                child: Text(
                  '競賽列表',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    for(int index = 0; index < gameInfoProvider.gameInfo.length; index++)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Container(
                          height: 150,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 5,
                              color: Colors.black,
                            )
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        gameInfoProvider.gameInfo[index]['game_name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        gameInfoProvider.gameInfo[index]['date'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                              ),
                              Flexible(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Image.network(
                                          gameInfoProvider.gameInfo[index]['home_team_icon'],
                                          width: 50,
                                          height: 50,
                                        ),
                                      )
                                    ),
                                    Flexible(             
                                      flex: 1,
                                      child: Center(
                                        child: Container(
                                          child: Text(
                                            gameInfoProvider.gameInfo[index]['home_team_name'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          'VS',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Container(
                                          child: Text(
                                            gameInfoProvider.gameInfo[index]['away_team_name'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Image.network(
                                          gameInfoProvider.gameInfo[index]['away_team_icon'],
                                          width: 50,
                                          height: 50,
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                    minimumSize: Size(50, 25),
                                  ),
                                  onPressed: (index != 0)? null:(){
                                    Navigator.pushNamed(context, '/chatroom', arguments: index);
                                  },
                                  child: Text((index == 0)? '進入聊天':'敬請期待'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              )
            ],
          ),

        ),
      ),
    );
  }

}