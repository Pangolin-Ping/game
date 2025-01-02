// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// import 'dart:html';

import 'dart:async';
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
    print(DateTime.now());
    print(DateTime.now().isAfter(DateTime(2025,1,3,16,50,0)));
    super.initState();
    sseConnect();
  }
  @override
  

  final homeController = TextEditingController();
  final awayController = TextEditingController();

  dynamic bettingInfo = {
    'home' : 0,
    'away' : 0,
    'home_rate' : 0,
    'away_rate' : 0,
  };

late StreamSubscription<String> streamSubscription;

void sseConnect() async {
  final client = http.Client();
  final request = http.Request(
    'GET',
    Uri.parse('https://cpbl-crawler-1.onrender.com/sse-betting-odds/1'),
  );
  final response = await client.send(request);

  streamSubscription = response.stream
      .transform(utf8.decoder)
      .listen((data) {
    if (data.length > 6) {
      data = data.substring(6);
    }
    try {
      bettingInfo = jsonDecode(data);
      setState(() {
        homeController.text = homeController.text;
        awayController.text = awayController.text;
      });
    } catch (e) {
      print("JSON Decode Error: $e");
    }
  });
}

@override
void dispose() {
  streamSubscription.cancel();
  super.dispose();
}

  @override
   Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer3<AccountInfoProvider, ChatRecordProvider, GameInfoProvider>(
      builder: (context, accountInfoProvider, recordProvider, gameInfoProvider,child) => 
      Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
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
                        child: ClipOval(
                          child: Image.network(
                            accountInfoProvider.stickerUrl,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '使用者名稱:      ${accountInfoProvider.username}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '　　錢　　:      ${accountInfoProvider.point}${(accountInfoProvider.bettingSide == 'None')? '':'(-${accountInfoProvider.bet_amount})'}',
                          style: TextStyle(
                            fontSize: 20,
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
                            padding: EdgeInsets.all(5),
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
                              fontSize: 20,
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
                            '賠率:${double.parse(bettingInfo['home_rate'].toStringAsFixed(2))}',
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 97,
                            height: 97,
                            padding: EdgeInsets.all(5),
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
                              fontSize: 20,
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
                            '賠率: ${double.parse(bettingInfo['away_rate'].toStringAsFixed(2))}',
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
                      child: SingleChildScrollView(
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
                                onPressed: (accountInfoProvider.bettingSide == 'away' || DateTime.now().isAfter(DateTime(2025,1,3,14,00,0)))? null:()async{
                                  late Map<String, Object> param;
                                  try{
                                    param = {
                                      'username' : accountInfoProvider.username,
                                      'game_id' : index+1,
                                      'bet_amount' : int.parse(homeController.text),
                                      'bet_side': "home",
                                      "end_time": "2025-01-03T17:08:06.932Z",
                                    };
                                    try{
                                      final di = Dio(BaseOptions(
                                        followRedirects: true,
                                      ));
                                      await di.post('${Constant.gameUrl}batting_item_create_and_update/', data: param);
                                      await accountInfoProvider.getBattingInfo(index);
                                      print("下注成功");
                                    }
                                    catch(e){
                                      print(e);
                                    }
                                  }catch(e){
                                    print("請輸入整數");
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
                      )
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Flexible(
                      flex: 1,
                      child: SingleChildScrollView(
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
                                onPressed: (accountInfoProvider.bettingSide == 'home' || DateTime.now().isAfter(DateTime(2025,1,3,14,00,0)))? null:()async{
                                  final param = {
                                    'username' : accountInfoProvider.username,
                                    'game_id' : index+1,
                                    'bet_amount' : int.parse(awayController.text),
                                    'bet_side': "away",
                                    "end_time": "2025-01-03T17:08:06.932Z",
                                  };
                                  try{
                                    final di = Dio(BaseOptions(
                                      followRedirects: true,
                                    ));
                                    await di.post('${Constant.gameUrl}batting_item_create_and_update/', data: param);
                                    await accountInfoProvider.getBattingInfo(index);
                                    print('下注成功');
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
                      )
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