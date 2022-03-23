import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pai_traning/auth_error.dart';
import 'home.dart';

class Registration extends StatefulWidget{
  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<Registration>{
  String newEmail = '';
  String newPassword = '';
  String newInfo = '';

  // firebaseのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  late User user;

  // エラーメッセージを日本語化
  final auth_error = AuthError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration Form', style: TextStyle(color: Colors.white70),),
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: TextFormField(
                onChanged: (String value){
                  newEmail = value;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: TextFormField(
                obscureText: true,
                maxLength: 20,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password(8~20文字)',
                ),
              ),
            ),

            // 登録失敗時のエラーメッセージ
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(newInfo, style: TextStyle(color: Colors.redAccent),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ElevatedButton(
                child: Text('登録', style: TextStyle(color: Colors.white70, fontSize: 25),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10))
                ),
                onPressed: () async {
                  try {
                    result = await auth.createUserWithEmailAndPassword(email: newEmail, password: newPassword);

                    user = result.user!;
                    if(user != null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return Home(user_id: user.uid, key: null,
                      );
                    }));
                    }
                  } on FirebaseAuthException catch (e){
                    setState(() {
                      newInfo = auth_error.register_error_msg(e.code);
                    });
                  }
                },
              ),
            ),
          ],
        )
    );
  }
}