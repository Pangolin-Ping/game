
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:math";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:software_project/Constant.dart";
import "package:software_project/Warning.dart";

class GameInfoProvider extends ChangeNotifier{
  List<Map<dynamic, dynamic>> homePlayerInfo = [];
  List<Map<dynamic, dynamic>> awayPlayerInfo = [];
  List<Map<dynamic, dynamic>> gameInfo = [];
  Map<String, List<Map<String, dynamic>>> compInfo = {};
  bool state = true;

  String nowEvent = '目前沒有最新資訊';
  void checkNowEvent(){
    try{
      nowEvent = '第${compInfo.keys.last[0]}局${compInfo.keys.last[2]}半: ${compInfo[compInfo.keys.last]?.last['batting_summary']}';
    }catch(e){  
      nowEvent = '目前沒有最新資訊';
    }
  }

  Future<void> getGameinfo() async{
    state = false;
    notifyListeners();
    gameInfo = [];
    var response = await Dio().get('${Constant.gameUrl}game_info');
    dynamic data = response.data;
    for(int i = 0; i < data.length; i++){
      dynamic singleGameData = data[i];
      Map<String, dynamic> temp = {};
      for(var key in singleGameData.keys){
        temp[key] = singleGameData[key];
      }
      gameInfo.add(temp);
    }
    state = true;
    notifyListeners();
  }

  Future<void> getPlayerInfo(int index) async{
    homePlayerInfo = [];
    awayPlayerInfo = [];
    var response = await Dio().get('${Constant.gameUrl}player_info/${gameInfo[index]['id']}');
    dynamic data = response.data;
    var hPlayerInfo = data.where((people) => people['team'] == '${gameInfo[index]['home_team_name']}');
    var aPlayerInfo = data.where((people) => people['team'] == '${gameInfo[index]['away_team_name']}');
    hPlayerInfo.forEach((person) => homePlayerInfo.add(person));
    aPlayerInfo.forEach((person) => awayPlayerInfo.add(person));
    print(hPlayerInfo);
  }

  void getSinglePlayerInfo(BuildContext context, int gameId, dynamic player,bool isHome){
    String icon_ = "";

    print(isHome);

    if(isHome){
      print('sdasdsad');
      print(gameInfo[gameId]['home_team_icon']);
      icon_ = gameInfo[gameId]['home_team_icon'];
    }else{
      print('daskdnmasd');
      icon_ = gameInfo[gameId]['away_team_icon'];
    }

    print(icon_);



    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: SizedBox(
            width: 400,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: Image.network(icon_, height: 200,width: 200),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: Image.network(player['icon'], height: 200,width: 200,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                  return Image.network('https://www.cpbl.com.tw/theme/client/images/player_no_img.jpg', 
                                  width: 200, 
                                  height: 200
                                  );
                                },),
                              )
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child:Center(
                          child: Text(
                            textAlign: TextAlign.start,
                            player['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child:
                              Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?   '防禦率\n${player['history_performance']['era']}':'上壘數\n${player['history_performance']['at_bats']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '每局被上壘數\n${player['history_performance']['whip']}':'一壘安打數\n${player['history_performance']['singles']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '被全壘打數\n${player['history_performance']['home_runs_allowed']}':'三壘安打數\n${player['history_performance']['triples']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '被安打數\n${player['history_performance']['hits_allowed']}':'上壘成功率\n${player['history_performance']['batting_average']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                          ],
                        )
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '三振數\n${player['history_performance']['strikeouts']}':'打擊率\n${player['history_performance']['hits']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '保送數\n${player['history_performance']['walks']}':'二壘安打數\n${player['history_performance']['doubles']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              child:Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  (player['position'] == "投手")?  '滾飛比\n${player['history_performance']['ground_fly_ratio']}':'全壘打數\n${player['history_performance']['home_runs']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getCompInfo(Duration duration) async{
    compInfo = {};
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String now_time = '${hours}:${minutes}:${seconds}';

    var response = await Dio().get('${Constant.gameUrl}game_events_before_time/1/${now_time}');
    print(response.data);
    try{
      for (var event in response.data){
        var param = {
          'batter_icon': event['batter_icon'],
          'current_score':event['current_score'],
          "batting_number": event['batting_number'],
          "batting_summary": event['batting_summary'],
          "batting_result": event['batting_result'],
          "pitches_count":event['pitches_count'].last,
        };
        print(param);
        for(int i = 0; i <  event['pitches_count'].last.length; i++)
          print(event['pitches_count'].last[i]);
        if(compInfo[event['inning_name']] == null){
          compInfo[event['inning_name']] = [];
        }
        compInfo[event['inning_name']]?.add(param);
      }
    }catch(e){
      print(e);
    }
    print(compInfo);
    checkNowEvent();
    notifyListeners();
  }

  void showCompInfo(BuildContext context, int gameId){
    showDialog(
      context: context, builder: (context){
        return AlertDialog(
          content: compInfo.isEmpty? 
          Center(
            child: Container(
              height: 500,
              width: 400,
              alignment: Alignment.center,
              child: Text(
                'No data',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          )
          :Container(
            height: 500,
            width: 400,
            child: ListView(
              children: [
                for(var key in compInfo.keys)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all( 5),
                    width: 400,
                    height: 120*(compInfo[key]!.length.toDouble()-1),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '${key[0]}\n${key[2]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              for(var event in compInfo[key]!)
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Padding(padding: 
                                              EdgeInsets.all( 2),
                                              child: Image.network(
                                                Uri.encodeFull(event['batter_icon']),
                                                width: 90, 
                                                height: 90,
                                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                                  return Image.network('https://www.cpbl.com.tw/theme/client/images/player_no_img.jpg', 
                                                  width: 90,
                                                  height: 90); 
                                                },
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Text(
                                                      event['batting_summary'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            Flexible(
                                                              child: Center(
                                                                child: Row(
                                                                  children: [
                                                                    for(int i = 0; i < int.parse(event['pitches_count'][0]); i++)
                                                                      Container(height: 10, width: 10, margin: EdgeInsets.all(1), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow))
                                                                  ],
                                                                ),
                                                              )
                                                            ),
                                                            Flexible(
                                                              child: Center(
                                                                child: Row(
                                                                  children: [
                                                                    for(int i = 0; i < int.parse(event['pitches_count'][2]); i++)
                                                                      Container(height: 10, width: 10, margin: EdgeInsets.all(1), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green))
                                                                  ],
                                                                ),
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: (event['batting_result'] == "三振")? Colors.red:Colors.green,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              event['batting_result'],
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          )
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Center(
                                                          child: Text(
                                                            event['current_score'],
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                            ],
                          ), 
                        )
                      ],
                    ),
                  ),

              ],
            ),
          )
        );
      }
    );
  }
}