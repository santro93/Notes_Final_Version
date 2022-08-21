import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_notes/model/note.dart';
import 'package:task_notes/service/firebasenote_service.dart';
import 'package:task_notes/widgets/note_card.dart';

class SearchNote extends StatefulWidget {
  const SearchNote({Key? key}) : super(key: key);

  @override
  State<SearchNote> createState() => _SearchNoteState();
}

class _SearchNoteState extends State<SearchNote> {
  TextEditingController searchController = TextEditingController();
  bool isShowNotes = false;

  Future<List<Note>> searchNote() async {
    if (searchController.text.isNotEmpty) {
      return await FirebaseNoteService.instance
          .searchNote(searchController.text);
    }
    return [];
    // final snapshot = await ref
    //     .where('title', isGreaterThanOrEqualTo: searchController.text)
    //     .get();
    // final List<Note> notes = [];
    // for (var element in snapshot.docs) {
    //   final note = Note.fromJson(element);
    //   notes.add(note);
    // }
    // return notes
    //     .where((element) => element.title!
    //         .toLowerCase()
    //         .contains(searchController.text.toLowerCase()))
    //     .toList();
  }

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
            controller: searchController,
            onSubmitted: (String) {
              setState(() {
                isShowNotes = true;
              });
            },
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: "Search Notes",
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        backgroundColor: Colors.green[400],
      ),
      body: FutureBuilder<List<Note>>(
          future: searchNote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final note = snapshot.data![index];
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
