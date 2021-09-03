import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic_app/controllers/music_controller.dart';

class MusicItem extends StatelessWidget {
  final String? title;
  final String? artist;
  final String? album;
  final Function? playMusic;
  final bool? isPlaying;

  final MusicController musicC = Get.find();

  MusicItem({
    this.title,
    this.artist,
    this.album,
    this.playMusic,
    this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        playMusic!();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              height: 60,
              width: 60,
              child: Image.network(
                album!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '-',
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    artist ?? '-',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            isPlaying! ? Icon(Icons.play_arrow) : Container()
          ],
        ),
      ),
    );
  }
}
