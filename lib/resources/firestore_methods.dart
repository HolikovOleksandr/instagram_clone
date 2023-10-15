import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Upload post
  Future<String> uploadPost(
    String desctiption,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = 'Some error';

    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        uid: uid,
        likes: [],
        postId: postId,
        postUrl: postUrl,
        username: username,
        desctiption: desctiption,
        profileImage: profileImage,
        datePublished: DateTime.now(),
      );

      _db.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
