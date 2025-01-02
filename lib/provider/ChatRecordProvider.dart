// ignore_for_file: empty_catches, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Constant.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRecordProvider extends ChangeNotifier{
  late WebSocketChannel socket;
  String uuid = "";
  List<types.Message> chatRecord = [];
  int count = 0;
  bool state = true;

  void initConnect(String username)async{
    state = false;
    notifyListeners();
    chatRecord = [];
    var response = await Dio().get('${Constant.ip}getAllMessage');
    var allMsg = jsonDecode(response.data)["messages"];
    print(allMsg);
    insertAllMsg(allMsg);
    print('ws${Constant.ip.substring(5)}ws?username=$username');
    try{
      socket.sink.close();
    }catch(e){
      print(e);
    }
    socket = WebSocketChannel.connect(Uri.parse("ws${Constant.ip.substring(5)}ws?username=$username"));
    socket.stream.listen((data){
      try{
        final msg = jsonDecode(data);
        print(msg);
        if(msg['topic'] == 'msg'){
          insertInputMsg(msg);
        }
        if(msg['topic'] == 'uuid'){
          uuid = msg['uuid'];
          notifyListeners();
        }
      }catch(e){
        print(e);
      }
    },
    onDone: (){
      print("daskndoasnfsndogsjodvnoszvjozsovnsizovnosnvosjbnpobnobno");
    }
    
    );
    state = true;
    notifyListeners();

  }

  void insertAllMsg(dynamic msg){
    try{
      print(msg);
      for(int  i = 0; i < msg.length; i++) {
        chatRecord.insert(0, types.TextMessage(
          author: types.User(
            id: msg[i]['author'],
            firstName: msg[i]['author'],
            imageUrl: (msg[i]['sticker'] == 0)? Constant.manIconUrl:Constant.womanIconUrl,
          ), 
          createdAt: DateTime.parse(msg[i]['timestamp']).millisecond,
          id: Uuid().v4(), 
          text: msg[i]['message'],
        ),
        );
      }
    }
    catch(e){
      print(e);
    }
    notifyListeners();
  }

  void insertInputMsg(dynamic msg){
    
    chatRecord.insert(0, types.TextMessage(
      author: types.User(
        id: msg['username'],
        imageUrl: Constant.manIconUrl,
        firstName: msg['username'],
      ), 
      createdAt: DateTime.now().millisecond,
      id: Uuid().v4(), text: msg['word']));
    notifyListeners();
  }
}

