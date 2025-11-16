import 'package:dio/dio.dart';
import '../models/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '6fc234b63f254fe92849019255a9ace6'; 

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await _dio.get(
      '$_baseUrl/movie/popular',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'page': 1,
      },
    );

    final List results = response.data['results'];
    return results.map((item) => Movie.fromJson(item)).toList();
  }

  Future<Movie> fetchMovieDetail(int id) async {
    final response = await _dio.get(
      '$_baseUrl/movie/$id',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
      },
    );

    return Movie.fromJson(response.data);
  }
}
