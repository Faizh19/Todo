import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_2/task_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

Future<User?> googleSignIn() async {
  GoogleSignInAccount? googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    var result = await auth.signInWithCredential(credential);

    var user = auth.currentUser;
    print(user!.email);

    return user;
  }
}

Future<User?> signin(
    String email, String password, BuildContext context) async {
  try {
    var result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;
    // return Future.value(true);
    return user;
  } catch (e) {}

  return Future.value(null);
}
