import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_notes/model/note.dart';
import 'package:task_notes/widgets/note_card.dart';

class ArchievedNotes extends StatefulWidget {
  const ArchievedNotes({Key? key}) : super(key: key);

  @override
  State<ArchievedNotes> createState() => _ArchievedNotesState();
}

class _ArchievedNotesState extends State<ArchievedNotes> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notes Keep",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.green[400],
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref
              .where("isArchive", isEqualTo: true)
              .orderBy(
                "dateTime",
                descending: true,
              )
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "You have not yet saved Notes !",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                );
              }
              return ListView.builder(
                // controller: scrollController,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  final note = Note.fromJson(doc);
                  return NoteCard(note: note);
                },
              );
            } else {
              return const Center(
                child: Text("Loading Content..."),
              );
            }
          }),
    );
  }
}
