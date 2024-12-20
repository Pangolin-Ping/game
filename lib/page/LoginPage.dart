// ignore: file_names
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_project/Warning.dart';
import 'package:software_project/provider/ChatRecordProvider.dart';
import 'package:software_project/provider/AccountInfoProvider.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:dio/dio.dart';
import 'package:software_project/provider/GameInfoProvider.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final accountController = TextEditingController();
    final passwordController = TextEditingController();
    accountController.text = '123';
    passwordController.text = '123';
    return Consumer3<AccountInfoProvider, ChatRecordProvider, GameInfoProvider>(
      builder: ( context, accountInfoProvider, chatRecordProvider, gameInfoProvider, child) =>
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/CPBL.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 40,color: Colors.black),
                  SizedBox(width: 20),
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
                          hintText: 'Enter your account',
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.key, size: 35,color: Colors.black),
                  SizedBox(width: 20,),
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
                          hintText: 'Enter your password',
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 60),
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
                    width: 80,
                    child: TextButton(
                      onPressed: () async{
                        Navigator.pushNamed(context, '/register');
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
                  SizedBox(width: 7),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    height: 40,
                    width: 160,
                    child: TextButton(
                      onPressed: () async{
                        var param = {
                          'username' : accountController.text,
                          'password' : passwordController.text,
                        };
                        try{
                          // await gameInfoProvider.readPlayerJson();
                          await gameInfoProvider.getGameinfo();
                          await accountInfoProvider.login(context,param);
                        }
                        on DioException catch(e){
                          if (e.response?.statusCode == 404) { 
                            Warning.showAccountErrorWarning(context);
                            return;
                          } 
                          else { 
                            print('Error: ${e.response?.statusCode}'); 
                          }
                          return;
                        }
                        chatRecordProvider.initConnect();
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Text(
                        '登入',
                        style: TextStyle(
                          height: -0.2,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}