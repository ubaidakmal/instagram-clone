import 'package:flutter/material.dart';
import 'package:insta/utiles/colors.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  const SearchBar({super.key,required this.searchController});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: mobileBackgroundColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child:  TextField(
        controller: widget.searchController,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 8, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none),
      ),
    );
  }
}