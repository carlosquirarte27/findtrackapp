import 'package:flutter/material.dart';
import 'item_fav.dart';
import 'package:url_launcher/url_launcher.dart';


class actualSong extends StatefulWidget {
  final artist;
  final album;
  final image;
  final title;
  final g_link;
  final spotify;
  final apple;
  const actualSong(
      {super.key, this.artist, this.album, this.image, this.title, this.apple,this.spotify,this.g_link});

  @override
  State<actualSong> createState() => _actualSongState();
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'No se pudo acceder a: $_url';
}

class _actualSongState extends State<actualSong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ItemFav(favData: {
              'fav': true,
              'title': widget.title,
              'picture': widget.image,
              'author': widget.artist
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                     _launchURL("${widget.spotify}");
                  },
                  icon: Icon(Icons.music_note),
                  color: Colors.white,
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    _launchURL("${widget.spotify}");
                  },
                  icon: Icon(Icons.podcasts_rounded),
                  color: Colors.white,
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    _launchURL("${widget.apple}");
                  },
                  icon: Icon(Icons.apple),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
