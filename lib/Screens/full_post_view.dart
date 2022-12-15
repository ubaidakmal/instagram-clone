import 'package:flutter/material.dart';
import 'package:insta/widgets/cache_image.dart';

class FullPostView extends StatefulWidget {
  final String url;
  const FullPostView({super.key, required this.url});

  @override
  State<FullPostView> createState() => _FullPostViewState();
}

class _FullPostViewState extends State<FullPostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cachedNetworkImage(widget.url,
          height: double.infinity, width: double.infinity),
    );
  }
}
