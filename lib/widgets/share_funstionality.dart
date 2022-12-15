import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class ProductShare extends StatefulWidget {
  const ProductShare({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductShareState createState() => _ProductShareState();
}

class _ProductShareState extends State<ProductShare> {
  @override
  Widget build(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              Share.share("ShareAble link",
                  subject: "Share Product",
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/share.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
