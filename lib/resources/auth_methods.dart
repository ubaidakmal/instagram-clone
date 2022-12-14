import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/models/user_model.dart';
import 'package:insta/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get userData from Database
  Future<UserModel>getUserDetails()async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users')
        .doc(currentUser.uid).get();
    return UserModel.fromSnap(snapshot);
  }

  // Sign up User Function

  Future<String> signUpUser({
    required String userName,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //save user email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // save user data to database
        String photoUrl = await StorageMethod()
            .uploadImageToStorage('ProfilePics', file, false);
        // if wanna save data on the base of Uid
        UserModel user = UserModel(
            email: email,
            uid: cred.user!.uid,
            photourl: photoUrl,
            username: userName,
            bio: bio,
            followers: [],
            following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        // if not wanna save data on the base of Uid
        // await _firestore.collection('users').add({
        //   'username': userName,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });
        res = "Success";
      }
    }
    // if want to check firebase Auth issues than use this method
    // on FirebaseAuthException catch(err){
    //   if(err.code =='invalid-email')
    //     {
    //       res ="The email is badly formatted";
    //     }
    //   else if(err.code =='weak-password')
    //   {
    //     res ="Your password should be more than 6 characters";
    //   }
    // }

    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Login function

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
