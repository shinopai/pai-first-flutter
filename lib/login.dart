import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pai_traning/auth_error.dart';
import 'home.dart';
import 'registration.dart';

class Login extends StatefulWidget{
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login>{
  String loginEmail = '';
  String loginPassword = '';
  String loginInfo = '';

  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;
  late User user;

  final authError = AuthError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form', style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.lightGreen,
      ),
      bottomNavigationBar: bottomButton(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: TextFormField(
              onChanged: (String value){
                loginEmail = value;
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
              onChanged: (String value){
                loginPassword = value;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(loginInfo, style: TextStyle(color: Colors.redAccent),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ElevatedButton(
              child: Text('ログイン', style: TextStyle(color: Colors.white70, fontSize: 25),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                padding: MaterialStateProperty.all(EdgeInsets.all(10))
              ),
              onPressed: () async {
                try {
                  result = await auth.signInWithEmailAndPassword(email: loginEmail, password: loginPassword);

                  user = result.user!;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Home(user_id: user.uid, key: null,);
                  }));
                } on FirebaseAuthException catch (e){
                    setState(() {
                      loginInfo = authError.login_error_msg(e.code);
                    });
                }
              },
            ),
          ),
        ],
      )
    );
  }

  Widget bottomButton() {
    return BottomAppBar(
      color: Colors.lightBlueAccent,
      child: TextButton(
        child: Text('アカウントを作成する', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20),),
        style: TextButton.styleFrom(
          primary: Colors.lightBlueAccent
        ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Registration();
          }));
        },
      ),
    );
  }
}

