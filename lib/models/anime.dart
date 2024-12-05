class Anime {
  final String judul;
  final num? rating;
  final String deskripsi;
  final String gambar;
  final int? episode;
  final int? popularitas;
  final String? startDate;

  Anime({
    required this.judul,
    required this.rating,
    required this.deskripsi,
    required this.gambar,
    required this.episode,
    required this.popularitas,
    required this.startDate,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        judul: json['node']['title'] ?? '',
        gambar: json['node']['main_picture']?['large'] ?? '',
        startDate: json['node']['start_date'],
        deskripsi: json['node']['synopsis'] ?? 'No description available',
        rating: (json['node']['mean'] as num?)?.toDouble(),
        popularitas: json['node']['popularity'] as int?,
        episode: json['node']['num_episodes'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'rating': rating,
        'deskripsi': deskripsi,
        'gambar': gambar,
        'episode': episode,
        'popularitas': popularitas,
        'start_date': startDate,
      };
}
