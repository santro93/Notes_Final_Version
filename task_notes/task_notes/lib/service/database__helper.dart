import 'package:task_notes/model/note.dart';
import 'package:task_notes/service/firebasenote_service.dart';
import 'package:task_notes/service/sqlflite_service.dart';

class DatabaseHelper {
  DatabaseHelper._privateconstructor();

  static void addNote({required String title, required String des}) async {
    String id =
        await FirebaseNoteService.instance.addNote(title: title, des: des);
    //SqfLiteDatabase.addNote(id: id, title: title, desc: desc);
  }

  static void updateNote(Note note) {
    FirebaseNoteService.instance.updateNote(note);
  }

  static void deleteNote(Note note) {
    FirebaseNoteService.instance.deleteNote(note);
  }
}
