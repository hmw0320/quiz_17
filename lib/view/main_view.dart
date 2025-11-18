import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_17_app/model/list.dart';
import 'package:quiz_17_app/view/add_view.dart';
import 'package:quiz_17_app/view/detail_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late String imagePath;
  late String workList;
  late bool action;
  late List<TodoList> todoList;

  @override
  void initState() {
    super.initState();
    imagePath = '';
    workList = '';
    action = false;
    todoList = [];
    addData();
  }

  addData(){
    todoList.add(TodoList(imagePath: 'images/cart.png', workList: '책 구매'));
    todoList.add(TodoList(imagePath: 'images/clock.png', workList: '철수와 약속'));
    todoList.add(TodoList(imagePath: 'images/pencil.png', workList: '스터디 준비하기'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async{
              var returnValue = 
              await Get.to(
                AddView(),
                arguments: [imagePath, workList, action]
              );
              rebuildData(returnValue);
            },
            icon: Icon(Icons.add_outlined)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(todoList[index]),
                onDismissed: (direction) {
                  todoList.remove(todoList[index]);
                  setState(() {});
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.delete_forever,
                    size: 40,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      DetailView(),
                      arguments: [todoList[index].imagePath, todoList[index].workList]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: index % 2 == 0 ? const Color.fromARGB(0, 255, 255, 255) : const Color.fromARGB(130, 255, 255, 255),
                      child: Row(
                        children: [
                          Image.asset(
                            todoList[index].imagePath,
                            width: 100,
                          ),
                          Text(
                            "   ${todoList[index].workList}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  } // build

  // Functions ---------------------
  rebuildData(var returnValue){
    
    if(returnValue != null){
      if(returnValue[2]){
        todoList.add(TodoList(imagePath: returnValue[0], workList: returnValue[1]));
        returnValue[2] = false;
      }
    }
    setState(() {});
  }

} // class