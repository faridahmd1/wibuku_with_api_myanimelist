import 'package:flutter/material.dart';
import 'package:wibuku/models/anime.dart';

class Detail extends StatelessWidget {
  final Anime? anime;

  const Detail({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    // Judul Section
    Widget judulSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            anime!.judul,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people_alt, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Popularitas: ${anime!.popularitas}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                'Rating: ${anime!.rating}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.video_collection, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Episode: ${anime!.episode ?? 'Unknown'}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );

    // Deskripsi Section
    Widget deskripsiSection = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sinopsis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.blue.shade200,
            thickness: 1.5,
          ),
          const SizedBox(height: 10),
          Text(
            anime!.deskripsi,
            style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );

    // Gambar Anime
    Widget gambarAnime = Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          anime!.gambar,
          fit: BoxFit.cover,
          width: 180,
          height: 250,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 180,
            height: 250,
            color: Colors.grey.shade200,
            child: const Icon(
              Icons.broken_image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text(
          anime!.judul,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            gambarAnime,
            const SizedBox(height: 20),
            judulSection,
            const SizedBox(height: 20),
            deskripsiSection,
          ],
        ),
      ),
    );
  }
}
