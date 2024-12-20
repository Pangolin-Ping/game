// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer2<AccountInfoProvider, GameInfoProvider>(
      builder: (context, accountInfoProvider, gameInfoProvider,child) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false
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
                    color: Colors.blue,
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
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 5,
                              color: Colors.black,
                            )
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    gameInfoProvider.gameInfo[index]['game_name'],
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    gameInfoProvider.gameInfo[index]['date'],
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    gameInfoProvider.gameInfo[index]['home_team_icon'],
                                    width: 80,
                                    height: 80,
                                  ),
                                  Text(
                                    gameInfoProvider.gameInfo[index]['home_team_name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'vs',
                                      style: TextStyle(
                                        fontSize: 50,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    gameInfoProvider.gameInfo[index]['away_team_name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Image.network(
                                    gameInfoProvider.gameInfo[index]['away_team_icon'],
                                    width: 80,
                                    height: 80,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green,
                                      minimumSize: Size(100, 50),
                                    ),
                                    onPressed: (index != 0)? null:(){
                                      Navigator.pushNamed(context, '/chatroom', arguments: index);
                                    },
                                    child: Text((index == 0)? '進入聊天':'敬請期待'),
                                  ),
                                ],
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