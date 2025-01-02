// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_project/page/BattingPage.dart';
import 'package:software_project/page/ChatRoomPage.dart';
import 'package:software_project/page/HomePage.dart';
import 'package:software_project/page/PlayerInfoPage.dart';
import 'package:software_project/page/RankingPage.dart';
import 'package:software_project/page/RegisterPage.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/page/LoginPage.dart';
import 'package:software_project/provider/ChatRecordProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';
import 'package:software_project/provider/RankingProvider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AccountInfoProvider()),
        ChangeNotifierProvider(create: (context)=> ChatRecordProvider()),
        ChangeNotifierProvider(create: (context)=> GameInfoProvider()),
        ChangeNotifierProvider(create: (context)=> RankingProvider()),
      ],
      child: MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.light,
        ),
        title: 'chatroom',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.white,
        ),
        routes: {
          '/chatroom': (context) => const ChatRoomPage(),
          '/home': (context) => const HomePage(),
          '/playerInfo':(context) => const PlayerInfoPage(),
          '/register': (context) => const RegisterPage(),
          '/batting': (context) => const BattingPage(),
          '/ranking': (context) => const RankingPage(),
        },
        home: LoginPage(),
      )
    );
  }
}