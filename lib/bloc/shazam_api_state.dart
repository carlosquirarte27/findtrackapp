part of 'shazam_api_bloc.dart';

abstract class ShazamApiState extends Equatable {
  const ShazamApiState();

  @override
  List<Object?> get props => [];
}

class ShazamApiInitialState extends ShazamApiState {}

class ShazamListeningState extends ShazamApiState {}

class ShazamFindedState extends ShazamApiState {
  final title;
  final album;
  final artist;
  final image;
  final apple;
  final spotify;
  final g_link;

  ShazamFindedState(
      {required this.title,
      required this.album,
      required this.artist,
      required this.image,
      required this.apple,
      required this.spotify,
      required this.g_link
      });

  @override
  List<Object?> get props => [title, album, artist, image,apple,spotify,g_link];
}

class ShazamFailedListening extends ShazamApiState {}
