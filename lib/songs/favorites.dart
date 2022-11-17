import 'package:flutter/material.dart';
import 'item_fav.dart';

class favoriteList extends StatefulWidget {
  const favoriteList({super.key});

  @override
  State<favoriteList> createState() => _favoriteListState();
}

class _favoriteListState extends State<favoriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ItemFav(favData: {
              'fav': false,
              'title': 'Counting Stars',
              'picture':
                  'https://i1.sndcdn.com/artworks-000040814493-eu3kr3-t500x500.jpg',
              'author': 'One republic'
            })
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}