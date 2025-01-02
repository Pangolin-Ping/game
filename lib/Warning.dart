// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Warning{
  static void showAccountExistWarning(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning, 
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  '使用者名稱\n已被使用!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            // content: Text('This is a warn window'),
            actions: [
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '確認',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            
            ],
          );
        },
      );
  }

  static void showPasswordComfirmWarning(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning, 
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  '密碼核對失敗\n請再次輸入密碼',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            // content: Text('This is a warn window'),
            actions: [
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '確認',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            
            ],
          );
        },
      );
  }

  static void showRegisterSuccessfulWarning(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning, 
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  '註冊成功',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            // content: Text('This is a warn window'),
            actions: [
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '確認',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
  }

  static void showAccountErrorWarning(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning, 
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  '帳號密碼錯誤',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            // content: Text('This is a warn window'),
            actions: [
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '確認',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
  }

}