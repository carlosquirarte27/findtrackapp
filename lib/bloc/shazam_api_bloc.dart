import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
part 'shazam_api_event.dart';
part 'shazam_api_state.dart';

final record = Record();

class ShazamApiBloc extends Bloc<ShazamApiEvent, ShazamApiState> {
  ShazamApiBloc() : super(ShazamApiInitialState()) {
    on<ShazamApiEvent>(hear);
  }

  FutureOr<void> hear(event, emit) async {
    bool permision = await record.hasPermission();
    if (!permision) {
      emit(ShazamFailedListening());
    } else {
      emit(ShazamListeningState());
      Directory temp = await getTemporaryDirectory();
      String? finalPath = '${temp.path}+Try.mp3';
      await record.start(path: finalPath);
      await Future.delayed(const Duration(seconds: 10), () {});
      finalPath = await record.stop();
      Uri url =
          Uri.parse('https://api.audd.io/?return=spotify,lyrics,apple_music');
      try {
        var request = MultipartRequest('POST', url);
        //var obj = {

        //};
        //request.fields.addAll(obj);
        request.headers['Content-Type'] = 'multipart/form-data';
        MultipartFile file = await MultipartFile.fromPath(
          'file',
          finalPath!,
        );
        request.files.add(file);
        StreamedResponse val;
        var res = await Response.fromStream(await request.send());

        if (res.statusCode == 200) {
          print('Uploaded!');
          dynamic resultado = jsonDecode(res.body);
          print(resultado);
          print(resultado['result']);
          if (resultado['result'] == null) {
            emit(ShazamFailedListening());
          } else {
            var artista = resultado['result']['artist'];
            var title = resultado['result']['title'];
            var album = resultado['result']['album'];
            var imagen =
                resultado['result']['spotify']['album']['images'][0]['url'];
            var apple = resultado['result']['apple_music']['url'];
            var spotify = resultado['result']['spotify']['external_urls']['spotify'];
            var g_link = resultado['result']['song_link'];
            emit(ShazamFindedState(
                title: title, album: album, artist: artista, image: imagen, apple: apple, g_link: g_link, spotify: spotify));
            print("Estamos avanzando");
          }
        }
      } catch (e) {
        print('Error: ' + e.toString());
      }
    }
    //emit(ShazamApiInitialState());
  }
}
