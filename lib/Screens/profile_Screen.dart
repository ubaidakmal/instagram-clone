import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/resources/firestore_methods.dart';
import 'package:insta/utiles/colors.dart';
import 'package:insta/widgets/cache_image.dart';
import 'package:insta/widgets/texted_button.dart';

import '../utiles/utiles.dart';

class ProfileScreen extends StatefulWidget {
  final String uUid;
  const ProfileScreen({super.key, required this.uUid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  int followersLength = 0;
  int followingLength = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var postsnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postsnap.docs.length;
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uUid)
          .get();
      userData = snap.data()!;
      followersLength = snap.data()!['followers'].length;
      followingLength = snap.data()!['following'].length;
      isFollowing = snap
          .data()!['following']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(userData['username'] ?? ''),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: cachedNetworkImage(
                                userData['photoUrl'] ??
                                    "https://play-lh.googleusercontent.com/NIUu0OgXQO4nU-ugWTv6yNy92u9wQFFfwvlWOsCIG-tPYBagOZdpyrJCxfHULI_eeGI",
                                height: 80,
                                width: 80),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildColumnState(postLength, "Posts"),
                                    buildColumnState(
                                        followersLength, "Followers"),
                                    buildColumnState(
                                        followingLength, "Followings"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uUid
                                        ? FollowButton(
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            borderColor: Colors.grey,
                                            text: "Edit Profile",
                                            textColor: primaryColor,
                                            function: () {},
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                backgroundColor: Colors.white,
                                                borderColor: Colors.grey,
                                                text: "Unfollow",
                                                textColor: Colors.black,
                                                function: () async {
                                                  await FireStoreMethods()
                                                      .followUser(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    userData['uid'],
                                                  );

                                                  setState(() {
                                                    isFollowing = false;
                                                    followersLength--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                backgroundColor: Colors.blue,
                                                borderColor: Colors.blue,
                                                text: "Follow",
                                                textColor: Colors.white,
                                                function: () async {
                                                  await FireStoreMethods()
                                                      .followUser(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    userData['uid'],
                                                  );

                                                  setState(() {
                                                    isFollowing = true;
                                                    followersLength++;
                                                  });
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(userData['username'] ?? '',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(userData['bio'] ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uUid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 1.5,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return SizedBox(
                              child: cachedNetworkImage(snap['postUrl']),
                            );
                          });
                    })
              ],
            ),
          );
  }

  Column buildColumnState(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
