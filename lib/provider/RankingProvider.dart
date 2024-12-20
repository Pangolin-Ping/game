// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import "package:dio/dio.dart";
import "package:flutter/material.dart" show  ChangeNotifier;
import "package:software_project/Constant.dart";

class RankingProvider extends ChangeNotifier{
  Map<String, int> ranking = {};

  Future<void> initRanking() async{
    try{
      var response =  await Dio().post('${Constant.ip}:7999/getAllUserInfo');
      print(response.data);
    }
    catch(e){
      print(e);
    }
  }
  
}
