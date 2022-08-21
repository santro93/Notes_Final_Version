import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_notes/model/note.dart';
import 'package:task_notes/screens/archieved_notes.dart';
import 'package:task_notes/screens/notes_keep.dart';
import 'package:task_notes/service/database__helper.dart';
import 'package:task_notes/service/firebasenote_service.dart';

class AddNote extends StatefulWidget {
  Note? note;
  AddNote({Key? key, this.note}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  late TextEditingController des;
  // = TextEditingController();
  bool isArchieve = false;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");

  void setUp() {
    if (widget.note != null) {
      title.text = widget.note?.title ?? "";
      des.text = widget.note?.des ?? "";
    }
  }

  @override
  void initState() {
    des = TextEditingController();
    setUp();
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    des.dispose(); //des
    super.dispose();
  }

  void addNote() async {
    if (widget.note != null) {
      final note = Note(
        id: widget.note!.id,
        title: title.text,
        des: des.text,
        isArchive: widget.note!.isArchive,
      );
      DatabaseHelper.updateNote(note);
    } else {
      DatabaseHelper.addNote(
        title: title.text,
        des: des.text,
      );
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NoteKeep()));
  }

  void deleteNote() async {
    if (widget.note != null) {
      await ref.doc(widget.note?.id!).delete();
      // Navigator.of(context).pop();
      DatabaseHelper.deleteNote(widget.note!);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => NoteKeep()));
    }
  }

  void archieveNote() async {
    if (widget.note != null) {
      final note = Note(
          id: widget.note!.id,
          title: title.text,
          des: des.text,
          isArchive: widget.note!.isArchive);
      await FirebaseNoteService.instance.archievedNotes();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ArchievedNotes()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: addNote, icon: const Icon(Icons.save)),
          IconButton(onPressed: deleteNote, icon: const Icon(Icons.delete)),
           IconButton(onPressed: (){}, icon: const Icon(Icons.punch_clock)),
          IconButton(
              onPressed: archieveNote,
              icon: isArchieve
                  ? const Icon(Icons.archive)
                  : const Icon(Icons.archive_outlined)),
        ],
        title: const Text(
          'Add Note',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      body: Center(
        child: Container(
          color: Colors.white70,
          // color: Colors.amberAccent[200],
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: des,
                decoration: const InputDecoration(
                  hintText: 'Note',
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
