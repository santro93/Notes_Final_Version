import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_notes/utils/profile.dart';

class UserDetail extends StatefulWidget {
  final String uid;
  const UserDetail({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  var userData = {};

  void getDetails() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      userData = snap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${userData['username']}",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.green[400],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(userData['photoUrl']),
                    radius: 50,
                  )
                  // 
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
