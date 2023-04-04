// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todo_list_2/task_page.dart';

// class Task {
//   // Task({super.key});
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   Future add(BuildContext context) async {
//     var time = DateTime.now();
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser?.uid)
//         .collection('Add Task')
//         .doc(time.toString())
//         .set({
//       'title': titleController.text,
//       'description': descriptionController.text,
//       'created': time.toString()
//     });
//   }

//   openDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               content: SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           "Add Task",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                         TextField(
//                           controller: titleController,
//                           decoration: const InputDecoration(
//                             hintText: "Enter Text Title",
//                             border: InputBorder.none,
//                           ),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black26,
//                           ),
//                         ),
//                         TextField(
//                           controller: descriptionController,
//                           decoration: const InputDecoration(
//                             hintText: "Enter Description",
//                             border: InputBorder.none,
//                           ),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black26,
//                           ),
//                         ),
//                         ElevatedButton(
//                             onPressed: (() async {
//                               await add(context);
//                               // Navigator.pushReplacement(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: ((context) => task_page())));
//                             }),
//                             child: Text("Save"))
//                       ])));
//         });
//   }
// }
