import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'songs/favorites.dart';

import 'songs/actual_song.dart';
import 'bloc/shazam_api_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String actualText = 'Tap to shazam';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF042442),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                actualText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 40),
              
              Container(
                child: BlocConsumer<ShazamApiBloc, ShazamApiState>(
                  listener: (context, state) {
                    if (state is ShazamListeningState) {
                      actualText = 'Listening...';
                    } else if (state is ShazamFindedState) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => actualSong(
                          image: state.image,
                          artist: state.artist,
                          album: state.album,
                          title: state.title,
                          apple: state.apple,
                          spotify: state.spotify,
                          g_link: state.g_link,
                        ),
                      ));
                    } else {
                      actualText = 'Tap to Shazam';
                    }
                    setState(() {});
                  },
                  builder: (context, state) {
                    if (state is ShazamListeningState) {
                      return AvatarGlow(
                        endRadius: 200,
                        animate: true,
                        child: GestureDetector(
                          onTap: () => print('Tapped'),
                          child: Material(
                            shape: CircleBorder(),
                            elevation: 8,
                            child: Container(
                              padding: EdgeInsets.all(40),
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF089af8)),
                              child: Image.asset(
                               'assets/spotify.png',
                                ),
                            ),
                          ),
                        ),
                      );
                    } 
                    else {
                      return GestureDetector(
                        onTap: () {
                          context.read<ShazamApiBloc>().add(ListeningEvent());
                          setState(() {});
                        },
                        child: Material(
                          shape: CircleBorder(),
                          elevation: 8,
                          child: Container(
                            padding: EdgeInsets.all(40),
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF089af8)),
                                child: Image.asset(
                               'assets/spotify.png',
                                height: 10),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => favoriteList(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 182, 193, 255)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        CircleBorder(),
                      ),
                      fixedSize: MaterialStateProperty.all(Size.fromRadius(10)),
                    ),
                  ),
                ],
                
              )
            ],
          )),
    );
  }
}
