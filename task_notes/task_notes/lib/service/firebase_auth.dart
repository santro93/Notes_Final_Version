import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_notes/model/user.dart' as model;
import 'package:task_notes/service/firebasenote_service.dart';
import 'package:task_notes/service/storagemethods.dart';
import 'package:task_notes/utils/constants.dart';

class FirebaseAuthentication {
  FirebaseAuthentication._privateCon();
  static final FirebaseAuthentication instance =
      FirebaseAuthentication._privateCon();
  static FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String result;
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = auth.currentUser?.uid;

      String photoUrl =
          await StorageMethods().uploadImageToStorage("ProfilePics", file);

      model.User user = model.User(
        username: name,
        email: email,
        password: password,
        photoUrl: photoUrl,
      );
      await firestore.collection('users').doc(uid).set(user.toJson());
      return true;
    } catch (err) {
      result = err.toString();
      return true;
    }
  }

  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    String result;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential != null;
    } catch (err) {
      result = err.toString();
      log("inside error");
      return false;
    }
  }

  void signOutUser() async {
    await auth.signOut();
    FirebaseNoteService.instance.resetData();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(isLoggedInkey, false);
  }

  Future<void> forgottenPassword({
    required String email,
  }) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
