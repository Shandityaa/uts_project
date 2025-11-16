import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  String? errorMessage;
  List<Movie> movies = [];
  Movie? selectedMovie;

  Future<void> getPopularMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchPopularMovies();
      movies = result;
    } catch (e) {
      errorMessage = "Gagal memuat data film.";
      if (kDebugMode) print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getMovieDetail(int id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final detail = await _apiService.fetchMovieDetail(id);
      selectedMovie = detail;
    } catch (e) {
      errorMessage = "Gagal memuat detail film.";
      if (kDebugMode) print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
// update