import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_2/Login_page.dart';
import 'package:todo_list_2/task_page.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController EmailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passowrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
        backgroundColor: Colors.grey.shade700,
        title: Text('Sign Up Here'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade700,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Create your account here with your email and passowrd',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: nameController,
                obscureText: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Enter Username",
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: EmailController,
                obscureText: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Enter E-mail",
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: passowrdController,
                obscureText: true,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Enter Password",
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () async {
                  var newUser = await auth.createUserWithEmailAndPassword(
                      email: EmailController.text,
                      password: passowrdController.text);
                  await newUser.user!.updateDisplayName(nameController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                },
                child: Text('Register Now')),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Row(children: [
                Text(
                  'Already have an account ?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: InkWell(
                    child: Text(
                      'Login here',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => (LoginScreen())));
                    },
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
