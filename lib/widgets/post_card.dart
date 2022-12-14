import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta/models/user_model.dart';
import 'package:insta/provider/user_provider.dart';
import 'package:insta/resources/firestore_methods.dart';
import 'package:insta/utiles/colors.dart';
import 'package:insta/utiles/utiles.dart';
import 'package:insta/widgets/cache_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Screens/comment_screen.dart';
import 'bottom_sheat.dart';
import 'like_animation.dart';

class MyPostCard extends StatefulWidget {
  final snap;

  const MyPostCard({Key? key, this.snap}) : super(key: key);

  @override
  State<MyPostCard> createState() => _MyPostCardState();
}

class _MyPostCardState extends State<MyPostCard> {
  bool onTap = false;
  bool saved = false;
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getTotalComments();
  }

  void getTotalComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: cachedNetworkImage(widget.snap['profImg'],height: 40,width: 40),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.snap['username']),
                ],
              ),
              InkWell(
                  onTap: () {
                    showOwnPostBottomSheet(context,widget.snap['postId']);
                  },
                  child: const Icon(Icons.more_horiz))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onDoubleTap: () {
            setState(() {
              onTap = !onTap;
            });
          },
          child: GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(
                  widget.snap['postId'], userModel.uid, widget.snap['likes']);
              setState(() {
                onTap = !onTap;
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: cachedNetworkImage(widget.snap['postUrl'])),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      isAnimation: isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: primaryColor,
                        size: 120,
                      )),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LikeAnimation(
                        isAnimation:
                            widget.snap['likes'].contains(userModel.uid),
                        smallLike: true,
                        child: InkWell(
                          onTap: () async {
                            await FireStoreMethods().likePost(
                                widget.snap['postId'],
                                userModel.uid,
                                widget.snap['likes']);
                            setState(() {
                              onTap = !onTap;
                            });
                          },
                          child: onTap == false
                              ? const FaIcon(FontAwesomeIcons.heart)
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                        snap: widget.snap,
                                      ))),
                          icon:
                              const FaIcon(FontAwesomeIcons.comment, size: 25)),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.share, size: 25)
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        // if(saved==false)
                        // {
                        //   Get.snackbar(
                        //       "Saved",
                        //       "In Collection",
                        //       icon: const Icon(Icons.person, color: Colors.white),
                        //       snackPosition: SnackPosition.TOP,
                        //       backgroundColor: Colors.black,
                        //       duration: const Duration(seconds: 2),
                        //       colorText: whiteColor
                        //   );
                        // }
                        // setState(() {
                        //   saved = !saved;
                        // });
                      },
                      child: saved == false
                          ? const Icon(Icons.save_alt)
                          : const Icon(
                              Icons.save_alt,
                              color: secondaryColor,
                            )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '${widget.snap['likes'].length} likes',
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    widget.snap['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    widget.snap['description'],
                  )
                ],
              ),
               Text(
                'View all $commentLen comments',
              ),
              const SizedBox(
                height: 5,
              ),
              Text(DateFormat.yMMMd()
                  .format(widget.snap['datePublished'].toDate()))
            ],
          ),
        ),
      ],
    );
  }
}
