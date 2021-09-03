import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic_app/controllers/music_controller.dart';
import 'package:mymusic_app/widgets/music_item.dart';

class HomeScreen extends StatelessWidget {
  final MusicController musicC = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Playing Now'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search
          Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: musicC.searchTextController,
              decoration: InputDecoration(
                hintText: 'Search Artist',
              ),
              onChanged: musicC.onSearchChanged,
            ),
          ),
          // List music
          Obx(
            () => Expanded(
              child: musicC.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: musicC.music.value.results!.length,
                      itemBuilder: (ctx, i) {
                        return MusicItem(
                          title: musicC.music.value.results![i].trackName,
                          artist: musicC.music.value.results![i].artistName,
                          album: musicC.music.value.results![i].artworkUrl100,
                          playMusic: () {
                            musicC.playMusic(
                                musicC.music.value.results![i].previewUrl!);
                          },
                          isPlaying:
                              musicC.music.value.results![i].previewUrl! ==
                                  musicC.currentMusic.value,
                        );
                      },
                    ),
            ),
          ),
          // Action button
          Material(
            elevation: 1,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_previous),
                      ),
                      IconButton(
                        onPressed: () {
                          musicC.isPlaying.value
                              ? musicC.pauseMusic()
                              : musicC.playMusic(musicC.currentMusic.value);
                        },
                        icon: Obx(
                          () => Icon(
                            musicC.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                  Obx(
                    () => Slider(
                      value: musicC.position.value.inSeconds.toDouble(),
                      min: 0.0,
                      max: musicC.durationLength.value.inSeconds.toDouble(),
                      onChanged: musicC.positionChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
