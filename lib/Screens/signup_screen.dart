import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/Screens/login_screen.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/utiles/colors.dart';
import 'package:insta/utiles/utiles.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_lyaout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/input_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    userNameController.dispose();
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpMethod() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      userName: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'Success') {
      if (!mounted) return;
      showSnackBar(res, context);
    } else {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    }
  }

  void navigateToLoginPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:  SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(flex: 2, child: Container()),
                    SvgPicture.asset(
                      'images/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                              ),
                        Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_a_photo)))
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextInputFields(
                      controller: userNameController,
                      textInputType: TextInputType.text,
                      hintText: 'Enter your username',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextInputFields(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter your email',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextInputFields(
                      controller: passwordController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter your password',
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextInputFields(
                      controller: bioController,
                      textInputType: TextInputType.text,
                      hintText: 'Enter your bio',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: signUpMethod,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            color: blueColor),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text('Sign up'),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text("Already have an account?"),
                        ),
                        GestureDetector(
                          onTap: navigateToLoginPage,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "Login.",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))),
    );
  }
}
