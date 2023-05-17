import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spotify_africa_assessment/models/playlist.dart';

class ApiService {
  static Future<List<Playlist>> fetchPlaylists(String categoryId, int offset, int limit) async {
    final url = 'https://api.spotify.com/v1/browse/categories/$categoryId/playlists?offset=$offset&limit=$limit';

    final headers = {
      'Authorization': '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ==',
      'x-functions-key': ApiKeys.spotifyApiKey,
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> playlistsData = data['playlists']['items'];

      return playlistsData.map((playlistData) => Playlist.fromJson(playlistData)).toList();
    } else {
      throw Exception('Failed to fetch playlists');
    }
  }
}
