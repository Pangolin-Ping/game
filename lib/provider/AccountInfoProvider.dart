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
  int point = 0;


  void setSticker(int value){
    stickerId = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, dynamic param)async{
      var response = await Dio().post('http://${Constant.ip}:7999/login',data: param);
      username = response.data['username'].toString();
      token = response.data['token'].toString();

      response = await Dio().post('http://${Constant.ip}:7999/userinfo', data:{'username': username});
      point = response.data['user']['point'];
      stickerUrl = (response.data['user']['sticker'] == 0)? Constant.manIconUrl:Constant.womanIconUrl;
      stickerSite = (response.data['user']['sticker'] == 0)? 'images\\manIcon.png':'images\\womanIcon.png';
  }

  void change(){
    ChangeNotifier();
  }
}
