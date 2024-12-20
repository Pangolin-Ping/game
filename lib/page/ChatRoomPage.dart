// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:software_project/Constant.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/ChatRecordProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';
import 'package:software_project/provider/RankingProvider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChatRoomPage extends StatefulWidget{

  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPage();
}

class _ChatRoomPage extends State<ChatRoomPage>{
  late YoutubePlayerController _controller;
  @override 
  void initState() { 
    super.initState(); 
    _controller = YoutubePlayerController( 
    initialVideoId: Constant.interviewUrl!, // 替換為你的直播視頻ID 
    flags: YoutubePlayerFlags( autoPlay: true, mute: false, ), 
    ); 
  }

  @override
  Widget build(BuildContext context){
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer4<AccountInfoProvider, ChatRecordProvider, GameInfoProvider, RankingProvider>(
      builder: (context, accountInfoProvider, recordProvider, gameInfoProvider, rankingProvider,child)=>
      Scaffold(
        backgroundColor: Colors.white,
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
                      onPressed: () async{
                        await gameInfoProvider.getPlayerInfo(index);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/playerInfo', arguments: index);
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(200, 50)
                      ),
                      child: Text(
                        'Betting',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      )
                    ),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        Navigator.pushNamed(context,'/batting', arguments: index);
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(200, 50)
                      ),
                      child: Text(
                        'Player Information',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      )
                    ),

                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        
                      ),
                    ),
                    
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        await rankingProvider.initRanking();
                        Navigator.pushNamed(context,'/ranking', arguments: index);
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
          leading: Builder(
            builder: (context){
              return IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
              );
            }
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 260,
                child: YoutubePlayer( 
                  controller: _controller, 
                  showVideoProgressIndicator: true, 
                  onReady: () { 
                    print('Player is ready.');
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  '${gameInfoProvider.gameInfo[index]['date']}   ${gameInfoProvider.gameInfo[index]['game_name']}' ,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 3,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                // padding: EdgeInsets.symmetric(vertical: 1),
                child: Container(
                  child: Chat(
                    messages: recordProvider.chatRecord, 
                    onSendPressed:(types.PartialText msg){
                      print(accountInfoProvider.username);
                      recordProvider.socket.sink.add(
                        json.encode(
                          {
                            'uuid': recordProvider.uuid,
                            'username' : accountInfoProvider.username,
                            'message' : msg.text,
                          }
                        )
                      );
                    },
                    showUserAvatars: true,
                    showUserNames: true,
                    user: types.User(
                      id: accountInfoProvider.username,
                      imageUrl: 'images/manIcon.png',
                    ), 
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ),
            ],
          )
        )
      ),
    );
  }
}
 