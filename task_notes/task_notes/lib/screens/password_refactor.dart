import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_notes/screens/signin.dart';
import 'package:task_notes/service/firebase_auth.dart';

class PasswordRefactor extends StatefulWidget {
  const PasswordRefactor({Key? key}) : super(key: key);

  @override
  State<PasswordRefactor> createState() => _PasswordRefactorState();
}

class _PasswordRefactorState extends State<PasswordRefactor> {
  TextEditingController emailController = TextEditingController();

  refactorPassword() {
    try {
      FirebaseAuthentication.instance
          .forgottenPassword(email: emailController.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SigninPage()),
      );
    } catch (err) {
      log("Invalid Email Id");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Refactor Screen',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.amber[500],
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Email to Send Code",
                prefixIcon: Icon(Icons.mail),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.green[400],
              onPressed: refactorPassword,
              child: const Text("Submit",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
