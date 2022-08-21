import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_notes/screens/notes_keep.dart';
import 'package:task_notes/screens/signin.dart';
import 'package:task_notes/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  bool? isLoggedIn = sharedPreferences.getBool(isLoggedInkey);
  runApp(MaterialApp(
    home: isLoggedIn ?? false ? NoteKeep() : const SigninPage(),
    debugShowCheckedModeBanner: false,
  ));
}
