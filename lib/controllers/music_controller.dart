import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mymusic_app/models/music.dart';

class MusicController extends GetxController {
  var music = Music().obs;
  var isLoading = false.obs;
  TextEditingController searchTextController = TextEditingController();
  String searchText = "";
  Timer? _debounce;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  var isPlaying = false.obs;
  var currentMusic = "".obs;
  var durationLength = Duration().obs;
  var position = Duration().obs;

  @override
  void onInit() {
    super.onInit();
    loadMusic();

    audioPlayer.onDurationChanged.listen((updatedDuration) {
      durationLength(updatedDuration);
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      print(updatedPosition);
      position(updatedPosition);
    });
  }

  loadMusic() async {
    isLoading(true);
    final url =
        Uri.parse('https://itunes.apple.com/search?term=jack+johnson&limit=25');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final musicResponse = musicFromJson(response.body);
      music(musicResponse);
    }
    isLoading(false);
  }

  searchMusic(String artist) async {
    isLoading(true);
    final url = Uri.parse(
        'https://itunes.apple.com/search?term=$artist&attribute=artistTerm');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final musicResponse = musicFromJson(response.body);
      music(musicResponse);
    }
    isLoading(false);
  }

  playMusic(String url) async {
    if (url != "") {
      currentMusic(url);
      isPlaying(true);
      await audioPlayer.play(url);
    }
  }

  pauseMusic() {
    isPlaying(false);
    audioPlayer.pause();
  }

  positionChanged(double position) {
    var updatedPosition = Duration(seconds: position.toInt());
    audioPlayer.seek(updatedPosition);
  }

  onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      searchMusic(value);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    searchTextController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
