// ignore_for_file: unnecessary_null_comparison, avoid_print
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';

class AuthMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _db.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = '';

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //
        // Save image to data base
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //
        // Add user to data base
        model.User user = model.User(
          uid: cred.user!.uid,
          bio: bio,
          email: email,
          photoUrl: photoUrl,
          username: userName,
          followers: [],
          following: [],
        );

        await _db.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Invalid email format';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email already in use';
      } else {
        res = err.toString();
      }
    }

    return res;
  }

  //
  // Login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = '';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        res = 'User wasn\'t found';
      } else if (error.code == 'wrong-password') {
        res = 'You enter an invalide password';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
