import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/components/current_song_box.dart';
import 'package:flutter_music_player_app/components/my_drawer.dart';
import 'package:flutter_music_player_app/models/playlist_provider.dart';
import 'package:flutter_music_player_app/models/song.dart';
import 'package:flutter_music_player_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    //navigate to the song page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    final Song song = playlist[index];
                    return ListTile(
                      title: Text(song.songName),
                      subtitle: Text(song.artistName),
                      leading: Image.asset(song.albumArtImagePath),
                      onTap: () => goToSong(index),
                    );
                  },
                ),
              ),
              const CurrentSongBar(),
            ],
          );
        },
      ),
    );
  }
}
