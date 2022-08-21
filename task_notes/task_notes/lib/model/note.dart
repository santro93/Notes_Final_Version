import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  String? title;
  String? des;
  Timestamp? dateTime;
  bool isArchive;

  Note({this.isArchive = false, this.id, this.title, this.des, this.dateTime});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': des,
        'dateTime': dateTime,
        "isArchive": isArchive,
      };

  static Note fromJson(DocumentSnapshot<Object?> doc) {
    // Map<String, dynamic> noteMap = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc["id"],
      title: doc["title"],
      des: doc["content"],
      dateTime: doc["dateTime"],
      isArchive: doc["isArchive"],
    );
  }
}
