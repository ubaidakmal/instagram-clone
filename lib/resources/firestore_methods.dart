import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:insta/models/post_model.dart';
import 'package:insta/resources/storage_method.dart';
import 'package:insta/utiles/utiles.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required Uint8List file,
    required String description,
    required String uid,
    required String username,
    required String profImg,
  }) async {
    String postId;
    String res = "Some error Occurred";
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      postId = const Uuid().v1();
      PostModel postModel = PostModel(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImg: profImg,
          likes: []);
      _firestore.collection('posts').doc(postId).set(postModel.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> likeComment(String postId, String uid, List likes) async {
    try {
      String commentId = const Uuid().v1();
      if (likes.contains(commentId)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          "likes": FieldValue.arrayRemove([commentId]),
        });
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          "likes": FieldValue.arrayUnion([commentId]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profImg, List likes) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          "profilePic": profImg,
          "name": name,
          "uid": uid,
          "text": text,
          "commentId": commentId,
          "datePublished": DateTime.now(),
          "likes": likes,
        });
      } else {
        print('Text is empty');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  // delete post method

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  // add followers as well as followings
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
