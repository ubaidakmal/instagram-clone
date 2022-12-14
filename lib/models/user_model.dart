import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const UserModel(
      {required this.email,
      required this.uid,
      required this.photourl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photourl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        email: snap['email'],
        uid: snap['uid'],
        photourl: snap['photoUrl'],
        username: snap['username'],
        bio: snap['bio'],
        followers: snap['followers'],
        following: snap['following']);
  }
}
