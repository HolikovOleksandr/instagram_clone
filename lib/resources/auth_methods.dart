// ignore_for_file: unnecessary_null_comparison
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //
  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = '';

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //
        // Add user to DB
        await _db.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

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
