import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta/resources/firestore_methods.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:get/get.dart';
import '../models/styles.dart';
import '../utiles/colors.dart';

showPostBottomSheet(BuildContext context) {
  showBarModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(builder: (BuildContext context,
          void Function(void Function()) setModalState) {
        return Container(
          color: mobileBackgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.share),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Share',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.link),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Link',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1,
                                      color: primaryColor,
                                      style: BorderStyle.solid)),
                              child: const Icon(Icons.save_alt)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Saved',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1,
                                      color: primaryColor,
                                      style: BorderStyle.solid)),
                              child: const Icon(Icons.add_circle_outline)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Remix',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.qr_code_scanner),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Qr Code',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: .5,
                    color: primaryColor.withOpacity(0.1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star_outline),
                    title: Text(
                      "Add to favorites",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_remove_outlined),
                    title: Text(
                      "Unfollow",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(
                      "Why you'ur seeing this post",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.visibility_off_outlined),
                    title: Text(
                      "Hide",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_outlined,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Report",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }));
}


showOwnPostBottomSheet(BuildContext context, String postId) {
  showBarModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(builder: (BuildContext context,
          void Function(void Function()) setModalState) {
        return Container(
          color: mobileBackgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.share),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Share',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.link),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Link',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1,
                                      color: primaryColor,
                                      style: BorderStyle.solid)),
                              child: const Icon(Icons.save_alt)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Saved',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                    style: BorderStyle.solid)),
                            child: const Icon(Icons.qr_code_scanner),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Qr Code',
                              style:
                              nameHeading.copyWith(color: primaryColor))
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: .5,
                    color: primaryColor.withOpacity(0.1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive_outlined),
                    title: Text(
                      "Achieve",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.heartCircleXmark),
                    title: Text(
                      "Hide like count",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.hide_source_outlined),
                    title: Text(
                      "Turn off commenting",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text(
                      "Edit",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.push_pin_outlined),
                    title: Text(
                      "Pin to your profile",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: Text(
                      "Post to other apps...",
                      style: nameHeadingBold.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: InkWell(
                      onTap: ()async{
                        showDialog(context: context, builder: (context)
                            {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                backgroundColor: Colors.transparent,
                                title: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 24, bottom: 21, right: 30, left: 30),
                                        child: Text(
                                          "Are you sure to delete the post?",
                                          style: TextStyle(color: mobileBackgroundColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              style: ButtonStyle(
                                                  textStyle: MaterialStateProperty.all(
                                                      const TextStyle(color: primaryColor),
                                                  ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(
                                              indent: 0,
                                              endIndent: 2,
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            TextButton(
                                              style: ButtonStyle(
                                                  textStyle: MaterialStateProperty.all(
                                                      const TextStyle(color: primaryColor),
                                                  ),
                                              ),
                                              onPressed: () async{
                                                FireStoreMethods().deletePost(postId);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: Text(
                        "Delete",
                        style: nameHeadingBold.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }));
}
