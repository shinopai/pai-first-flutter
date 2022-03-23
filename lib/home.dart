import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  final String user_id;
  Home({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome!!!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Text(user_id),
          ],
        ),
      ),
    );
  }
}