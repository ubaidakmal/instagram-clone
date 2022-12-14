// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta/dashboard/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? data;
  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/data.json")
        .then((value) {
      setState(() {
        data = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer:  Drawer(
        child: ListView(  
          // Important: Remove any padding from the ListView.  
          padding: EdgeInsets.zero,  
          children: [  
             Container(
              decoration: const BoxDecoration(
                color: Colors.amber
              ),
               child: UserAccountsDrawerHeader( 

                accountName: const Text("Ubaid Akmal"),  
                accountEmail: const Text("baidakmal20@gmail.com"),  
                currentAccountPicture: CircleAvatar(  
                  backgroundColor: Colors.orange,  
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data?[1]['image']??""),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50),
                    ),
                    ) 
                ),  
            ),
             ),  
            ListTile(  
              leading: const Icon(Icons.home), title: const Text("Home"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.settings), title: const Text("Settings"),  
              onTap: () {  
                Navigator.pop(context);
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.contacts), title: const Text("Contact Us"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),
            ListTile(  
              leading: const Icon(FontAwesomeIcons.powerOff), title: const Text("Logout"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
          ],  
        ),  
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  // ignore: unnecessary_null_comparison
                  itemCount: data == null ? 0 : data?.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data?[i]['rating'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data?[i]['artist'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data?[i]['title'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() =>  AudioPlayerScreen(audioData:data, index:i));
                                    },
                                    icon: const Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
