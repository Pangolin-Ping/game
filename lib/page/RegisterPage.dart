

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Constant.dart';
import 'package:software_project/Warning.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:software_project/provider/ChatRecordProvider.dart';
import 'package:software_project/provider/GameInfoProvider.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  
  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final accountController = TextEditingController();
    final passwordController = TextEditingController();
    final comfirmwordController = TextEditingController();
    int groupValue = 2;
    bool state = true;


    return Consumer3<AccountInfoProvider, ChatRecordProvider, GameInfoProvider>(
      builder: ( context, accountInfoProvider, chatRecordProvider, gameInfoProvider, child) =>
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/CPBL.png'),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                    controller: accountController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: GradientOutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        width: 2,
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [Colors.amber, Colors.white],
                        )
                      ),
                      hintText: '帳號',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.black26,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                    controller: comfirmwordController,
                    keyboardType: TextInputType.name,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '密碼',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.black26
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '再次輸入密碼',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.black26
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 250,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 0, 
                            groupValue: accountInfoProvider.stickerId, 
                            onChanged: (value){
                              accountInfoProvider.setSticker(value!);
                            }
                          ),
                          Text(
                            '男',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 1, 
                            groupValue: accountInfoProvider.stickerId,  
                            onChanged: (value){
                                accountInfoProvider.setSticker(value!); 
                            }
                          ),
                          Text(
                            '女',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                    width: 3,
                  )
                ),
                height: 40,
                width: 250,
                child: TextButton(
                  onPressed:(state == false) ? null:() async{
                    setState(() {
                      state = false;
                    });
                    if(passwordController.text != comfirmwordController.text) {
                      Warning.showPasswordComfirmWarning(context);
                      setState(() {
                      state = true;
                    });
                      return;
                    }
                    var param = {
                      'sticker': accountInfoProvider.stickerId,
                      'username' : accountController.text,
                      'password' : passwordController.text,
                    };
                    try{
                      var response = await Dio().post('${Constant.ip}register', data: param);
                      print(response.data['username']);
                      print('completed');
                    }
                    on DioException catch (e) { 
                      if (e.response?.statusCode == 500) { 
                        Warning.showAccountExistWarning(context);
                        setState(() {
                          state = true;
                        });
                        return;
                      } 
                      else { 
                        showDialog(
                        context: context, 
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text('$e'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          },
                        );
                        print('Error: ${e.response?.statusCode}'); 
                      }
                      setState(() {
                          state = true;
                      });
                      return;
                    }
                    Warning.showRegisterSuccessfulWarning(context);
                  },
                  child: Text(
                    '註冊',
                    style: TextStyle(
                      height: -0.2,
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}