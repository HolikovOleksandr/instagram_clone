class User {
  final String uId;
  final String bio;
  final String email;
  final String photoUrl;
  final String userName;
  final List<User> followers;
  final List<User> following;

  const User({
    required this.uId,
    required this.bio,
    required this.email,
    required this.photoUrl,
    required this.userName,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uId,
        'bio': bio,
        'email': email,
        'photoUrl': photoUrl,
        'username': userName,
        'followers': followers,
        'following': following,
      };
}
