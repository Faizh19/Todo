// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_2/Login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_2/authentication.dart';
import 'package:todo_list_2/task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user = FirebaseAuth.instance.currentUser;
  var isLogin = false;

  checkIfLogin() async {
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null && mounted) {
      setState(() {
        isLogin = true;
      });
    }
    // }
    // );
  }

  @override
  void initState() {
    checkIfLogin();
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? task_page(user: user!) : LoginScreen(),
      // body: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: ((context, snapshot) {
      //     // print('Print authstate data');
      //     print(snapshot);
      //     print(snapshot.hasData);
      //     if (ConnectionState.waiting == snapshot.connectionState) {
      //       return Container(
      //         child: CircularProgressIndicator.adaptive(),
      //       );
      //     }
      //     if (snapshot.hasData) {
      //       return task_page(
      //         user: auth.currentUser!,
      //       );
      //     } else {
      //       return LoginScreen();
      //     }
      //   }),
      // ),
    );
  }
}
