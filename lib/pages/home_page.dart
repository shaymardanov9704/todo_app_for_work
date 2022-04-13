
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/db/boxes.dart';
import 'package:todoapp/model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = '109210';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //status for color
  String status = 'white';



  final nameController = TextEditingController();


  @override
  void dispose() {
   // Hive.close();

    super.dispose();

    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Qaydnoma',
          style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

     //reading tasks from boxes db
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          return buildTasks(tasks);
        },
      ),

      //selection status color and task name
      bottomSheet: BottomSheet(
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.shade700,
                              border: status == 'green'
                                  ? Border.all(width: 3, color: Colors.black)
                                  : Border.all(width: 0)),
                        ),
                        onTap: () {
                          setState(() {
                            status = 'green';
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent,
                              border: status == 'red'
                                  ? Border.all(width: 3, color: Colors.black)
                                  : Border.all(width: 0)),
                        ),
                        onTap: () {
                          setState(() {
                            status = 'red';
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow,
                              border: status == 'yellow'
                                  ? Border.all(width: 3, color: Colors.black)
                                  : Border.all(width: 0)),
                        ),
                        onTap: () {
                          setState(() {
                            status = 'yellow';
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                              border: status == 'blue'
                                  ? Border.all(width: 3, color: Colors.black)
                                  : Border.all(width: 0)),
                        ),
                        onTap: () {
                          setState(() {
                            status = 'blue';
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrangeAccent,
                              border: status == 'orange'
                                  ? Border.all(width: 3, color: Colors.black)
                                  : Border.all(width: 0)),
                        ),
                        onTap: () {
                          setState(() {
                            status = 'orange';
                          });
                        },
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Task Name',
                            hintStyle: TextStyle(fontSize: 20),
                          ),
                        )),
                        Container(
                          width: 55,
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: Colors.black87),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                if (nameController.text.trim() == '' ||
                                    nameController == null) {
                                  showNameError(context);
                                } else {
                                  if (status == 'white' ||
                                    status == null) {
                                  showColorError(context);
                                } else {
                                  addTask(nameController.text.trim(), status);
                                  Navigator.pushReplacementNamed(context, HomePage.id);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //              HomePage()));
                                }
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
        onClosing: () {},
      ),
    );
  }

  //building tasks list
  Widget buildTasks(List<Task> tasks) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'Qaydnomalar hali yo`q!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];

                return buildTask(context, task);
              },
            ),
          ),
        ],
      );
    }
  }

  //build single task
  Widget buildTask(BuildContext context, Task task) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(right: 10, left: 10, top: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: task.status == 'green'
                    ? Colors.green
                    : task.status == 'red'
                        ? Colors.redAccent
                        : task.status == 'yellow'
                            ? Colors.yellow
                            : task.status == 'blue'
                                ? Colors.blue
                                : task.status == 'orange'
                                    ? Colors.deepOrangeAccent
                                    : Colors.white),
          ),
          Expanded(
              child: Text(
            task.name,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          )),
          Container(
            width: 55,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Colors.green.shade400),
            child: Center(
              child: IconButton(
                onPressed: () {
                  deleteTask(task);
                },
                icon: const Icon(Icons.done, color: Colors.white, size: 35),
              ),
            ),
          )
        ],
      ),
    );
  }

  //adding task to db
  Future addTask(String name, String status) async {
    final task = Task()
      ..name = name
      ..status = status;

    final box = Boxes.getTasks();
    box.add(task);
  }

  //delete task from db
  void deleteTask(Task task) {
    task.delete();
  }

  //show color error if it is null or empty
  showColorError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.redAccent,
          title: Text(
            "Rangni tanlang!!!",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  //show name error if it is null or empty

  showNameError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.redAccent,
          title: Text(
            "Qaydnoma nomini kiriting!!!",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
