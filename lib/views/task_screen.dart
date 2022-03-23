import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pai_traning/main.dart';

final GlobalKey<AnimatedListState> _listKey = GlobalKey();

class TaskScreen extends HookConsumerWidget{
  TaskScreen({Key? key}) : super(key: key);
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskModel = ref.watch(taskProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.check_box),
              title: Text('Task List'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 80,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                'Task List',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: taskModel.taskList.length,
                    itemBuilder:
                      (BuildContext context, int index, animation){
                      return _buildItem(
                        ref,
                        index,
                        Theme.of(context).secondaryHeaderColor,
                        animation
                      );
                      },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          int insertIndex = taskModel.taskList.length;
          taskModel.createTask('');
          _listKey.currentState?.insertItem(insertIndex,
          duration: Duration(milliseconds: 300));

          taskModel.taskList[taskModel.taskList.length - 1].focusNode.requestFocus();
        },
        tooltip: 'Add new task',
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _buildItem(
      WidgetRef ref,
      int index,
      Color dismissColor,
      Animation<double> animation){
      final taskModel = ref.watch(taskProvider);
      final id = taskModel.taskList[index].id;
      final title = taskModel.taskList[index].title;
      final check = taskModel.taskList[index].check;
      final focusNode = taskModel.taskList[index].focusNode;
      return SizeTransition(
        sizeFactor: animation,
        child: Dismissible(
          key: Key('${id.hashCode}'),
          background: Container(color: dismissColor,),
          confirmDismiss: (direction) async {
            return true;
          },
          onDismissed: (direction){
            _listKey.currentState?.removeItem(index,
                (context, animation) => SizedBox(width: 0, height: 0,));
            taskModel.deleteTask(id);
          },
          child: ListTile(
            leading: Checkbox(
              onChanged: (e){
                taskModel.updateCheck(id, !check);
              },
              value: check,
            ),
            title: TextFormField(
              focusNode: focusNode,
              autofocus: false,
              initialValue: title,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (value){
                taskModel.updateTask(id, value);
              },
              onFieldSubmitted: (value){
                if(value == ''){
                  _listKey.currentState?.removeItem(
                    index,
                      (context, animaton) =>
                          SizedBox(width: 0, height: 0,)
                  );
                  taskModel.deleteTask(id);
                }
              },
            ),
          ),
        ),
      );
}