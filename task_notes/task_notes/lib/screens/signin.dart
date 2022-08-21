import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_notes/screens/notes_keep.dart';
import 'package:task_notes/screens/password_refactor.dart';
import 'package:task_notes/screens/signup.dart';
import 'package:task_notes/service/firebase_auth.dart';
import 'package:task_notes/utils/constants.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? finalEmail;
  //////////////////   Email  Sign  In  /////////////
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signingIn() async {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 5000),
      content: const Text(
        "Account Is Logged In.",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      backgroundColor: Colors.green[400],
    );

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      bool success = await FirebaseAuthentication.instance.signInUser(
          email: emailController.text, password: passwordController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        //////////////// set SharedPreferences login ///////////////////////////
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(isLoggedInkey, true);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NoteKeep()));
      } else {
        final snackBar = SnackBar(
          duration: const Duration(milliseconds: 5000),
          content: const Text(
            "Account can't Sign In.",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.green[400],
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign In",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.amber[500],
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "  Password",
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.green[400],
                onPressed: signingIn,
                child: const Text("Sign In",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PasswordRefactor()),
                  );
                },
                child: const Text(
                  "Forgotten Password ?  Click Me",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Have Not Account ?",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.green[400],
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                child: const Text("Create Account",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
