
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:software_project/Constant.dart";

class GameInfoProvider extends ChangeNotifier{
  List<Map<dynamic, dynamic>> homePlayerInfo = [];
  List<Map<dynamic, dynamic>> awayPlayerInfo = [];
  List<Map<dynamic, dynamic>> gameInfo = [];

  Future<void> getGameinfo() async{
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

    print(response.data);
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
  }

  void getSinglePlayerInfo(BuildContext context, int gameId, dynamic player,bool isHome){
    print(player);
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: Container(
            width: 400,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                              child: Image.network(gameInfo[gameId][(isHome)?'away_team_icon':'home_team_icon'], height: 100,width: 100),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.network(player['icon'], height: 100,width: 100,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                return Image.network('https://www.cpbl.com.tw/theme/client/images/player_no_img.jpg', 
                                width: 100, 
                                height: 100
                                );
                              },),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child:Text(
                          textAlign: TextAlign.start,
                          player['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
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
                              Text(
                                textAlign: TextAlign.start,
                                '上壘數 : ${player['history_performance']['at_bats']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Text(
                                textAlign: TextAlign.start,
                                '一壘安打數 : ${player['history_performance']['singles']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Text(
                                textAlign: TextAlign.start,
                                '三壘安打數 : ${player['history_performance']['triples']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Text(
                                textAlign: TextAlign.start,
                                '上壘成功率 : ${player['history_performance']['batting_average']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                              child:Text(
                                textAlign: TextAlign.start,
                                '打擊率 : ${player['history_performance']['hits']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Text(
                                textAlign: TextAlign.start,
                                '二壘安打數 : ${player['history_performance']['doubles']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child:Text(
                                textAlign: TextAlign.start,
                                '全壘打數 : ${player['history_performance']['home_runs']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.start,
                                '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
}