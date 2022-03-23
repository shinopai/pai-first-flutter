import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pai_traning/views/task_screen.dart';
import 'models/task_view_model.dart';

final taskProvider = ChangeNotifierProvider((ref) => TaskViewModel());

void main() {
  runApp(ProviderScope(child: PaiApp()));
}

class PaiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pai Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: PaiHomePage(),
    );
  }
}

class PaiHomePage extends StatefulWidget {
  @override
  State<PaiHomePage> createState() => _PaiHomePageState();
}

class _PaiHomePageState extends State<PaiHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pai Task'),
        backgroundColor: Colors.deepOrange,
      ),
      body: TaskScreen()
    );
  }
}
