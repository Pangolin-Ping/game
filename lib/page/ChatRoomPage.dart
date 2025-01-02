// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously



import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
String now_time = "0:0:0";

class _ChatRoomPage extends State<ChatRoomPage>{
  late YoutubePlayerController _controller;
  late Timer? timer;
  @override 
  void initState(){ 
    super.initState(); 
    initController();
  }

  Future<void> initController() async{
    _controller = YoutubePlayerController( 
    
    initialVideoId: Constant.interviewUrl!, // 替換為你的直播視頻ID 
    flags: YoutubePlayerFlags( autoPlay: true, mute: false), 
    ); 
    getGameEvent();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getGameEvent();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  void getGameEvent() async{
    Provider.of<GameInfoProvider>(context, listen: false).getCompInfo(_controller.value.position);
  }

  

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer4<AccountInfoProvider, ChatRecordProvider, GameInfoProvider, RankingProvider>(
      builder: (context, accountInfoProvider,recordProvider, gameInfoProvider, rankingProvider,child)=>
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
                        'Player Information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      )
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        await accountInfoProvider.getBattingInfo(index);
                        Navigator.pushNamed(context,'/batting', arguments: index);
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(200, 50)
                      ),
                      child: Text(
                        'Batting',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      )
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: MediaQuery.of(context).orientation == Orientation.landscape? null: AppBar(
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
        body: LayoutBuilder(
          builder: (context, constraints){
            if(MediaQuery.of(context). orientation == Orientation.landscape){
              return Expanded(
                child: YoutubePlayer( 
                  controller: _controller, 
                  showVideoProgressIndicator: true, 
                  onReady: () { 
                    print('Player is ready.');
                  },
                )
              );
            }
            else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 215,
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
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                      child: Text(
                        '${gameInfoProvider.gameInfo[index]['date']}   ${gameInfoProvider.gameInfo[index]['game_name']}' ,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: GestureDetector(
                        onTap: (){
                          gameInfoProvider.showCompInfo(context, index);
                        }, 
                        child: Container(
                          width: 400,
                          child:Text(
                            gameInfoProvider.nowEvent,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              width: 0,
                              color: Colors.black,
                            ),  
                          ),
                        )
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
                          inputOptions: InputOptions(),
                          messages: recordProvider.chatRecord, 
                          theme: DefaultChatTheme(
                            inputTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ) ,
                            receivedMessageBodyTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ) ,
                            sentMessageBodyTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ) 
                          ),
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
              );
            }
          },
        )
      ),
    );
  }
}

class SafeText extends StatelessWidget {
  final String text;

  SafeText(this.text);

  @override
  Widget build(BuildContext context) {
    try {
      print(text);
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      );
    } catch (e) {
      return Text(
        '目前沒有最新資訊',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }
}
