import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../providers/auth_provider.dart';
import '../models/movie.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieProvider>(context, listen: false)
          .getPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
      body: movieProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProv.errorMessage != null
              ? Center(child: Text(movieProv.errorMessage!))
              : ListView.builder(
                  itemCount: movieProv.movies.length,
                  itemBuilder: (_, i) {
                    final Movie movie = movieProv.movies[i];
                    return ListTile(
                      leading: movie.posterPath.isNotEmpty
                          ? Image.network(
                              "https://image.tmdb.org/t/p/w92${movie.posterPath}",
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.movie),
                      title: Text(movie.title),
                      subtitle: Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/detail",
                          arguments: movie.id,
                        );
                      },
                    );
                  },
                ),
    );
  }
}
// update