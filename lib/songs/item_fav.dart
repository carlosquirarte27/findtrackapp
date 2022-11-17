import 'package:flutter/material.dart';

class ItemFav extends StatefulWidget {
  final Map<String, dynamic> favData;
  ItemFav({Key? key, required this.favData}) : super(key: key);

  @override
  State<ItemFav> createState() => _ItemFavState();
}

class _ItemFavState extends State<ItemFav> {
  bool _switchValue = false;
  @override
  void initState() {
    _switchValue = widget.favData["fav"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.favData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _switchValue ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  _switchValue = !_switchValue;
                  setState(() {});
                },
              ),
              title: Text(
                "${widget.favData["title"]}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "${widget.favData["author"]}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
