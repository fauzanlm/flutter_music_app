import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/models/playlist_provider.dart';

import 'package:provider/provider.dart';

class CurrentSongBar extends StatelessWidget {
  const CurrentSongBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playlistProvider = Provider.of<PlaylistProvider>(context);
    final song =
        playlistProvider.playlist[playlistProvider.currentSongIndex ?? 0];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: 65,
          // height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        song.albumArtImagePath,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.songName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        song.artistName,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_border_rounded,
                      size: 35,
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: playlistProvider.pauseOrResume,
                      child: Icon(
                        playlistProvider.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 0,
            ),
          ),
          child: Slider(
            min: 0,
            max: playlistProvider.totalDuration.inSeconds.toDouble(),
            value: playlistProvider.currentDuration.inSeconds.toDouble(),
            activeColor: Colors.green,
            onChanged: (double val) {},
            onChangeEnd: (double val) {
              // playlistProvider.seek(
              //   Duration(seconds: val.toInt()),
              // );
            },
          ),
        ),
      ],
    );
  }
}
