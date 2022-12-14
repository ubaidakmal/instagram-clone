import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/Screens/add_post_screen.dart';
import 'package:insta/Screens/feed_screen.dart';
import 'package:insta/Screens/profile_Screen.dart';
import 'package:insta/Screens/search_screen.dart';

const webScreenSize = 600;

final homeScreenItems = [
  const FeedScreen(),
  const SearchView(),
  const AddPostScreen(),
  const Text('notifications'),
   ProfileScreen(uUid: FirebaseAuth.instance.currentUser!.uid,)
];
