import 'package:flutter/material.dart';
import 'package:task_notes/model/note.dart';
import 'package:task_notes/screens/addnote.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => AddNote(
                    note: note,
                  )),
        );
      },
      child: Card(
        elevation: 20,
        color: Colors.cyanAccent[100],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title :- ${note.title}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "Content :- ${note.des}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              // Text(
              //   "Date & Time :- ${note.dateTime}",
              //   style: const TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black87,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
