// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import "package:dio/dio.dart";
import "package:flutter/material.dart" show  ChangeNotifier;
import "package:software_project/Constant.dart";

class Third<A, B, C>{
  final A first;
  final B second;
  final C third;

  Third(this.first, this.second, this.third);
}

class RankingProvider extends ChangeNotifier{
  List<Third> ranking =[];
  int l1 = 0;
  int l2 = 0;

  Future<void> initRanking() async{
    
    
    ranking = [];
    print('rrrrrrrrr');
    try{
      var response =  await Dio().get('${Constant.ip}getAllUserInfo');
      dynamic users = response.data['user'];
      for(var user in users){
        ranking.add(Third(user['username'], user['point'], user['sticker']));
      }
      ranking.sort((b,a) => a.second.compareTo(b.second));
      if(ranking.length <= 3){
        l2 = 0;
        l1 = ranking.length;
      }
      else{
        l2 = ranking.length;
        l1 = 3;
      }
    }
    catch(e){
      print(e);
    }
    for(var p in ranking){
      print("${p.first} ${p.second}");
    }
  }
  
}
