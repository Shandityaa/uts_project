import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieProvider>(context, listen: false)
          .getMovieDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MovieProvider>(context);
    final Movie? movie = prov.selectedMovie;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Film")),
      body: prov.isLoading
          ? const Center(child: CircularProgressIndicator())
          : prov.errorMessage != null
              ? Center(child: Text(prov.errorMessage!))
              : movie == null
                  ? const Center(child: Text("Data tidak ditemukan"))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (movie.posterPath.isNotEmpty)
                            Image.network(
                              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                            ),
                          const SizedBox(height: 16),
                          Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(movie.overview),
                        ],
                      ),
                    ),
    );
  }
}
