import 'package:flutter/material.dart';
import 'package:wibuku/models/anime.dart';
import 'package:wibuku/view_models/fetchAnime.dart';
import 'package:wibuku/view/airing_list.dart';
import '../view/all_list.dart';
import '../view/favorite_list.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Anime>>(
        future: fetchAnime(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 60, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return Menu(
              all: snapshot.data,
              airing: snapshot.data,
              favorite: snapshot.data,
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final List<Anime>? all;
  final List<Anime>? airing;
  final List<Anime>? favorite;

  const Menu({
    super.key,
    required this.all,
    required this.airing,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wibuku',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(primary: Colors.blue),
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Wibukuy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[700],
            bottom: const TabBar(
              indicatorColor: Colors.blue,
              tabs: [
                Tab(
                  text: "All",
                  icon: Icon(Icons.list_alt),
                ),
                Tab(
                  text: "Airing",
                  icon: Icon(Icons.air),
                ),
                Tab(
                  text: "Favorite",
                  icon: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AllList(anime: all),
              AiringList(anime: airing),
              FavoriteList(anime: favorite),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Implementasi action jika dibutuhkan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Floating Action Button Clicked')),
              );
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
