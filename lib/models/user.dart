import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String bio;
  final String email;
  final List followers;
  final List following;
  final String photoUrl;
  final String username;

  const User({
    required this.uid,
    required this.bio,
    required this.email,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'bio': bio,
        'email': email,
        'photoUrl': photoUrl,
        'username': username,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
