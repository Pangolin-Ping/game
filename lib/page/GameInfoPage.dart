// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';

class GameInfoPage extends StatefulWidget{
  const GameInfoPage({super.key});

  @override
  State<GameInfoPage> createState() => _GameInfoPage();
}

class _GameInfoPage extends State<GameInfoPage>{
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer<GameInfoProvider>(
      builder: (conteext, gameInfoProvider,child) =>
      Scaffold(
        backgroundColor: Colors.white,
        
      ), 
    );
  }

}