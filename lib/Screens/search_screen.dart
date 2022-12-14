import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:insta/Screens/profile_Screen.dart';
import 'package:insta/widgets/cache_image.dart';

import '../utiles/colors.dart';
import '../widgets/searh_bar.dart';

class SearchView extends StatefulWidget {
  final String title;
  const SearchView({super.key, this.title = ''});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController editingController = TextEditingController();
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: mobileBackgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: editingController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 8, // HERE THE IMPORTANT PART
                    ),
                    filled: true,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none),
                onFieldSubmitted: (String _) {
                  setState(() {
                    isShown = true;
                  });
                },
              ),
            ),
          ),
          body: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: editingController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return isShown
                    ? ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Get.to(
                              () => ProfileScreen(
                                uUid: (snapshot.data! as dynamic).docs[index]
                                    ['uid'],
                              ),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: cachedNetworkImage((snapshot.data! as dynamic).docs[index]
                                        ['photoUrl'], height: 30, width: 30),
                              ),
                              title: Text((snapshot.data! as dynamic)
                                  .docs[index]['username']),
                            ),
                          );
                        })
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              itemCount:
                                  (snapshot.data! as dynamic).docs.length,
                              itemBuilder: (context, index) => cachedNetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postUrl']),
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.count(
                                    (index % 7 == 0 ? 2 : 1),
                                    (index % 7 == 0 ? 2 : 1),
                                  ));
                        });
              })),
      // body: FutureBuilder(
      // future: FirebaseFireStore.i , builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:instagram_ui/styles/colors.dart';

// class SearchView extends StatefulWidget {
//   SearchView({ this.title=''}) ;
//   final String title;

//   @override
//   _SearchViewState createState() =>  _SearchViewState();
// }

// class _SearchViewState extends State<SearchView> {
//   TextEditingController editingController = TextEditingController();

//   final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//   var items = <String>[];

//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     super.initState();
//   }

//   void filterSearchResults(String query) {
//     List<String> dummySearchList = <String>[];
//     dummySearchList.addAll(duplicateItems);
//     if(query.isNotEmpty) {
//       List<String> dummyListData = <String>[];
//       dummySearchList.forEach((item) {
//         if(item.contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//         items.addAll(duplicateItems);
//       });
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//       child: Scaffold(
//         appBar:  AppBar(
//           centerTitle: true,
//           backgroundColor: blackColor,
//           title:  Text(widget.title),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   onChanged: (value) {
//                     filterSearchResults(value);
//                   },
//                   controller: editingController,
//                   decoration: const InputDecoration(
//                       labelText: "Search",
//                       hintText: "Search",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5.0)))),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(items[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }