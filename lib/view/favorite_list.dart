import 'package:flutter/material.dart';
import 'package:wibuku/models/anime.dart';
import 'detail.dart';

class FavoriteList extends StatelessWidget {
  final List<Anime>? anime;

  const FavoriteList({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    if (anime == null || anime!.isEmpty) {
      return const Center(
        child: Text('No favorite anime available'),
      );
    }

    final favoriteAnime =
        anime!.where((anime) => anime.popularitas != null && anime.popularitas! < 100).toList();

    if (favoriteAnime.isEmpty) {
      return const Center(
        child: Text('No favorite anime available'),
      );
    }

    return ListView.builder(
      itemCount: favoriteAnime.length,
      itemBuilder: (context, index) {
        final currentAnime = favoriteAnime[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(anime: currentAnime),
              ),
            );
          },
          child: AnimeCard(anime: currentAnime),
        );
      },
    );
  }
}

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                anime.gambar,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 140,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.judul,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Episode: ${anime.episode ?? 'Unknown'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow,),
                        const Text(' '),
                        Text(
                          '${anime.rating ?? 'Unknown'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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