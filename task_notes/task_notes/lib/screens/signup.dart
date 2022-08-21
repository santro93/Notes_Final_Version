import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:task_notes/screens/signin.dart';
import 'package:task_notes/service/firebase_auth.dart';
import 'package:task_notes/utils/profile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isObscure = true;
  Uint8List? _image;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String template = "";

////////////// Account  Create  ////////////////////////////
  Future<void> _createAccount() async {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 5000),
      content: const Text(
        "Account Is Created Successfully.",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      backgroundColor: Colors.green[400],
    );

    if (name.text.isNotEmpty &&
            email.text.isNotEmpty &&
            password.text.isNotEmpty
        && _image != null
        ) {
      FirebaseAuthentication.instance.signUp(
        name: name.text,
        email: email.text,
        password: password.text,
        file: _image!
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninPage()),
      );
    } else {
      var snackBar = const SnackBar(
        duration: Duration(milliseconds: 5000),
        content: Text(
          "Account Is Not Created.",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 56, 61, 56),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _switchToSignin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SigninPage()));
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Task Notes",
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200/300'),
                        ),
                  Positioned(
                    left: 70,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: name,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(gapPadding: 7),
                  hintText: "Enter Your Full Name",
                ),
                // validator: (value) {
                //   if (value!.isEmpty ||
                //       !RegExp(r'^[A-Z(1) a-z]+$').hasMatch(value)) {
                //     return "Enter Correct Your Full Name";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              //  TextFormField(
              //   controller: name,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(gapPadding: 7),
              //     hintText: "Enter Your Mobile No",
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty ||
              //         !RegExp(r'^[+]*[(]{0,1}{0-9}{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value!)) {
              //       return "Enter Correct Your Mobile No";
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(gapPadding: 7),
                  hintText: "Enter Your Email Id",
                ),
                // validator: (value) {
                //   if (value!.isEmpty ||
                //       !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                //           .hasMatch(value)) {
                //     return "Enter Correct  Email Id";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(gapPadding: 7),
                  labelText: "Enter Your Password",
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
                // validator: (value) {
                //   if (value!.isEmpty ||
                //       !RegExp(r'^[A-Z{1} a-z{2,}]+$').hasMatch(value)) {
                //     return "Enter Correct Password";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _createAccount,
                // if (formKey.currentState!.validate()) {
                //   final snackBar = SnackBar(
                //       content: Text("Account Is Created Successfully."));
                //   _scaffoldKey.currentState!.showSnackBar(snackBar);
                // }

                color: Colors.green[400],
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Have Already Account ?",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _switchToSignin,
                color: Colors.green[400],
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
