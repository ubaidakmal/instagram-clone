import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      drawer: const Drawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/image2.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Ubaid Akmal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 5,
                ),
                const Text("Flutter Developer", style: TextStyle(fontSize: 12),), 
                const SizedBox(
                  height: 10,
                ),
                const Text("baidAkmal20@gmail.com"),
              ],
            ),
        ),
      ),
    );
  }
}
