import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final List likes;
  final String uid;
  final String postId;
  final String postUrl;
  final String username;
  final String desctiption;
  final String profileImage;
  final DateTime datePublished;

  const Post({
    required this.uid,
    required this.likes,
    required this.postId,
    required this.postUrl,
    required this.username,
    required this.desctiption,
    required this.profileImage,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'likes': likes,
        'postId': postId,
        'postUrl': postUrl,
        'username': username,
        'desctiption': desctiption,
        'profileImage': profileImage,
        'datePublished': datePublished,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      username: snapshot['username'],
      desctiption: snapshot['desctiption'],
      profileImage: snapshot['profileImage'],
      datePublished: snapshot['datePublished'],
    );
  }
}
