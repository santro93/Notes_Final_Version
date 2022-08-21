import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String password;
  // final Uint8List file;
  final String photoUrl;
  const User({
    required this.username,
    required this.email,
    required this.password,
    // required this.file,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        // 'file': file,
        'photoUrl': photoUrl
      };

  static User fromJson(DocumentSnapshot<Object?> doc) {
    return User(
      email: doc["email"],
      username: doc["username"],
      password: doc["password"],
      // file: doc["file"],
      photoUrl: doc["photoUrl"],
    );
  }
}
