// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import "package:dio/dio.dart";
import "package:flutter/material.dart" show BuildContext, ChangeNotifier;
import "package:software_project/Constant.dart";

class AccountInfoProvider extends ChangeNotifier{
  String password = "";
  String token = "";
  String username = "";
  int stickerId = 0;
  String stickerUrl = "";
  String stickerSite = "";
  String bettingSide = "None";
  int bet_amount = 0;
  int point = 0;
  bool state = true;


  void setSticker(int value){
    stickerId = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, dynamic param)async{
      state = false;
      notifyListeners();
      var response = await Dio().post('${Constant.ip}login',data: param);
      username = response.data['username'].toString();
      token = response.data['token'].toString();

      response = await Dio().post('${Constant.ip}userinfo', data:{'username': username});
      point = response.data['user']['point'];
      stickerUrl = (response.data['user']['sticker'] == 0)? Constant.manIconUrl:Constant.womanIconUrl;
      stickerSite = (response.data['user']['sticker'] == 0)? 'images\\manIcon.png':'images\\womanIcon.png';
      state = true;
      notifyListeners();
  }

  Future<void> getBattingInfo(int index) async{
    state = false;
    notifyListeners();
    var response = await Dio().get('${Constant.gameUrl}batting_item/${username}/${index+1}');
    var data = response.data;
    try{
      print(data);
      bettingSide = data['bet_side'];
      bet_amount = data['bet_amount'];
    }
    catch(e){
      print(e);
      bettingSide = "None";
      bet_amount = 0;
    }
    notifyListeners();
  }


  void change(){
    ChangeNotifier();
  }
}
