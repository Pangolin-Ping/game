// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Constant.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';
import 'package:software_project/provider/RankingProvider.dart';

class RankingPage extends StatefulWidget{
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPage();

}

class _RankingPage extends State<RankingPage>{
  

  @override 
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer3<GameInfoProvider,AccountInfoProvider,RankingProvider>(
      builder: (context, gameInfoProvider, accountInfoProvider, rankingProvider, child) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i = 0; i < rankingProvider.l1; i++)
                      Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black
                                )
                              ),
                              child: Image.network((rankingProvider.ranking[i].third == 0)? Constant.manIconUrl:Constant.womanIconUrl, height: 70,width: 70,),
                            ),
                            Text(
                              rankingProvider.ranking[i].first ,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              rankingProvider.ranking[i].second.toString() ,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ( i != 0)?
                            Text(
                              '${i+1}' ,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w700,
                                color: Colors.amber,
                              ),
                            ):
                            Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.amber,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                flex: 8,
                child: ListView(
                  children: [
                    for(int i = 3; i < rankingProvider.l2; i++)
                      Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black
                                )
                              ),
                              child: Image.network((rankingProvider.ranking[i].third == 0)? Constant.manIconUrl:Constant.womanIconUrl, height: 60,width: 60,),
                            ),
                            Text(
                              rankingProvider.ranking[i].first ,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              rankingProvider.ranking[i].second.toString() ,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${i+1}' ,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
