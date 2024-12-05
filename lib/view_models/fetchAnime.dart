import '../models/anime.dart';

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

Future<List<Anime>> fetchAnime(http.Client client) async {
  var header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'X-MAL-CLIENT-ID': '19c228bd578bb6b96c950576d33baa88'
  };

  // Menggunakan Future.wait untuk menjalankan tiga permintaan API secara bersamaan
  var responses = await Future.wait([
    client.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime/ranking?ranking_type=all&fields=title,main_picture,start_date,end_date,synopsis,mean,rank,popularity,num_episodes&limit=100'),
      headers: header),
    client.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime/ranking?ranking_type=airing&fields=title,main_picture,start_date,end_date,synopsis,mean,rank,popularity,num_episodes&limit=100'),
      headers: header),
    client.get(
      Uri.parse(
          'https://api.myanimelist.net/v2/anime/ranking?ranking_type=favorite&fields=title,main_picture,start_date,end_date,synopsis,mean,rank,popularity,num_episodes&limit=10'),
      headers: header)
  ]);

  // Memproses semua respons dan menggabungkannya menjadi satu list
  return [
    ...parseAnime(responses[0]),
    ...parseAnime(responses[1]),
    ...parseAnime(responses[2]),
  ];
}

List<Anime> parseAnime(http.Response response) {
  // Memeriksa apakah statusCode adalah 200
  if (response.statusCode == 200) {
    // Mengambil data dari respons JSON dan mengonversi ke List<Anime>
    var jsonData = json.decode(response.body)['data'] as List;
    return jsonData.map((item) => Anime.fromJson(item)).toList();
  } else {
    // Jika statusCode bukan 200, lempar exception
    throw Exception('Failed to load anime: ${response.statusCode}');
  }
}
