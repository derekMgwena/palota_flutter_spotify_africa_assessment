/*import 'package:flutter/material.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatelessWidget {
  const SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/api_service.dart';

class SpotifyPlaylist extends StatelessWidget {
  final String playlistId;

  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist Detail'),
      ),
      body: FutureBuilder<Playlist>(
        future: ApiService.fetchPlaylist(playlistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch playlist'));
          } else if (snapshot.hasData) {
            final playlist = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Image.network(playlist.image),
                const SizedBox(height: 16),
                Text(
                  playlist.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Followers: ${playlist.followers.toStringAsFixed()}'),
                const SizedBox(height: 16),
                Text(
                  playlist.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tracks:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: playlist.tracks.length,
                  itemBuilder: (context, index) {
                    final track = playlist.tracks[index];
                    return ListTile(
                      leading: Image.network(track.albumImage),
                      title: Text(track.name),
                      subtitle: Text(track.artists.join(', ')),
                      trailing: Text(track.duration),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Artists:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: playlist.uniqueArtists.map((artist) {
                      return Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(artist.image),
                          ),
                          const SizedBox(height: 8),
                          Text(artist.name),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

