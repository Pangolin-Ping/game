// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// import 'dart:html';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Constant.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/ChatRecordProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';
import 'package:http/http.dart' as http;

class BattingPage extends StatefulWidget{
  const BattingPage({super.key});

  @override
  State<BattingPage> createState() => _BattingPage();
}

class _BattingPage extends State<BattingPage>{
  
  @override
  void initState(){
    super.initState();
    sseConnect();
  }

  final homeController = TextEditingController();
  final awayController = TextEditingController();

  dynamic bettingInfo = {
    'home' : 'Waiting...',
    'away' : 'Waiting...',
    'home_rate' : 'Waiting...',
    'away_rate' : 'Waiting...',
  };

  void sseConnect() async{
    final client = http.Client();
    final request = http.Request('GET', Uri.parse('https://cpbl-crawler-1.onrender.com/sse-betting-odds/1'));
    final response = await client.send(request);

    response.stream.transform(utf8.decoder).listen((data){
      data = data.substring(6);
      print(data);
      print(data.runtimeType);
      bettingInfo = jsonDecode(data);
      setState(() {
        homeController.text = homeController.text;
        awayController.text = awayController.text;
      });
    });
  }

  @override
   Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer3<AccountInfoProvider, ChatRecordProvider, GameInfoProvider>(
      builder: (context, accountInfoProvider, recordProvider, gameInfoProvider,child) => 
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(accountInfoProvider.stickerUrl),
                      )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '使用者名稱: ${accountInfoProvider.username}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '　　錢　　: ${accountInfoProvider.point}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: Image.network(
                              gameInfoProvider.gameInfo[index]['home_team_icon'],
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Text(
                            '目前下注金額',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${bettingInfo['home']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '賠率:${bettingInfo['home_rate']}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: Image.network(
                              gameInfoProvider.gameInfo[index]['away_team_icon'],
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Text(
                            '目前下注金額',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                       '${bettingInfo['away']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '賠率: ${bettingInfo['away_rate']}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 125,
                            child: TextFormField(
                              controller: homeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              onPressed: ()async{
                                final param = {
                                  'username' : accountInfoProvider.username,
                                  'game_id' : index+1,
                                  'bet_amount' : int.parse(homeController.text),
                                  'bet_side': "home",
                                  "end_time": "2024-12-31T05:31:16.395Z"
                                };
                                print(param);
                                try{
                                  final di = Dio(BaseOptions(
                                    followRedirects: true,
                                  ));
                                  await di.post('${Constant.gameUrl}batting_item_create_and_update/', data: param);
                                }
                                catch(e){
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                              child: Text(
                                '下注',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 125,
                            child: TextFormField(
                              controller: awayController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              onPressed: ()async{
                                final param = {
                                  'username' : accountInfoProvider.username,
                                  'game_id' : index+1,
                                  'bet_amount' : int.parse(awayController.text),
                                  'bet_side': "away",
                                  "end_time": "2024-12-31T05:31:16.395Z"
                                };
                                try{
                                  final di = Dio(BaseOptions(
                                    followRedirects: true,
                                  ));
                                  await di.post('${Constant.gameUrl}batting_item_create_and_update/', data: param);
                                }
                                catch(e){
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ),
                              child: Text(
                                '下注',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}