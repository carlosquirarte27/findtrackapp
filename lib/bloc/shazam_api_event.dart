part of 'shazam_api_bloc.dart';

abstract class ShazamApiEvent extends Equatable {
  const ShazamApiEvent();

  @override
  List<Object?> get props => [];
}

class ListeningEvent extends ShazamApiEvent {}

