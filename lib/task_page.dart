import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_2/Login_page.dart';
import 'package:todo_list_2/authentication.dart';
import 'package:todo_list_2/task.dart';

class task_page extends StatefulWidget {
  User user;
  task_page({super.key, required this.user});

  @override
  State<task_page> createState() => task_pageState();
}

class task_pageState extends State<task_page> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<dynamic> taskList = [];
  bool listData = false;

  Future<void> getList() async {
    final list = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Add Task')
        .get();

    taskList = list.docs;
    listData = true;
    setState(() {});
  }

  String getDate(String time) {
    String zzz;
    // zzz = DateFormat('dd-MM-yyyy').format(DateTime.parse(time));
    zzz = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // print
    return zzz;
  }

  Future add(BuildContext context) async {
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Add Task')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'created': time.toString()
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getList();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var google = GoogleSignIn();
    List<String> dropList = [user?.displayName ?? 'Null h bhai', 'Log out'];
    // Task task = Task();
    final gooleSignIn = GoogleSignIn();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () {
            // task.openDialog(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Add Task",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Text Title",
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26,
                                  ),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Description",
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: (() async {
                                      await add(context);
                                      Navigator.pop(context);
                                      getList();
                                      listData = false;
                                      setState(() {});
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: ((context) => task_page())));
                                    }),
                                    child: Text("Save"))
                              ])));
                });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade700,
          title: Text('Welcome '),
          centerTitle: true,
          actions: [
            DropdownButton(
                icon: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user?.photoURL ?? ""),
                ),
                items: dropList
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: ((value) async {
                  if (value == 'Log out') {
                    await FirebaseAuth.instance.signOut();
                    await google.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    //
                  }
                }))
          ],
        ),
        body: Container(
          color: Colors.grey.shade700,
          child: RefreshIndicator(
            onRefresh: () {
              listData = false;
              setState(() {});
              return getList();
            },
            child: listData
                ? ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      // Random random = Random();
                      // Color bg = myColors[random.nextInt(4)];
                      // String formattedTime =
                      //     DateFormat.yMMMd().add_jm().format(mydateTime);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white60,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${taskList[index]['title']}",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "${taskList[index]['description']}",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      getDate(taskList[index]['created']
                                          .toString()),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "lato",
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      alignment: Alignment.centerLeft,
                                      icon: Icon(Icons.delete),
                                      iconSize: 24.0,
                                      color: Colors.red,
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .collection('Add Task')
                                            .doc(taskList[index]['created']
                                                .toString())
                                            .delete();
                                        listData = false;
                                        setState(() {});
                                        getList();
                                      },
                                    ),
                                  ],
                                ),
                                //
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
  }
}
