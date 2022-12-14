import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../provider/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utiles/colors.dart';

class CommentCard extends StatefulWidget {
  final snap;

  const CommentCard({Key? key, this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool onTap=false;
  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: widget.snap['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: widget.snap['text'],
                      ),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                    ),
                  ),
                ],
              ),
            ),
          ),
          LikeAnimation(
            isAnimation:
            widget.snap['likes'].contains(userModel.uid),
            smallLike: true,
            child: InkWell(
              onTap: ()async{
                await FireStoreMethods().likeComment(
                    widget.snap['commentId'],
                    userModel.uid,
                    widget.snap['likes']);
                setState(() {
                  onTap = !onTap;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: onTap == false
                    ? const FaIcon(FontAwesomeIcons.heart,size: 16,)
                    : const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
