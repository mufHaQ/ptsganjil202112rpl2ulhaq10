// ignore_for_file: unused_import

import "dart:math";
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ptsganjil202112rpl2ulhaq10/custom_function/debug_print.dart';
import 'package:ptsganjil202112rpl2ulhaq10/pages/movie_detail.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  List genres = [];
  List genresList = [];
  List genresString = [];
  List listForRandom = [for (var i = 1; i <= 10; i += 1) i];
  bool fetchLoading = true;
  bool isRefresh = false;

  dynamic apiKey,
      apiToken,
      url,
      resultId,
      name,
      adult,
      backdropPath,
      originalTitle,
      originalLanguage,
      overview,
      popularity,
      posterPath,
      releaseDate,
      voteAverage,
      voteCount;

  @override
  void initState() {
    super.initState();

    apiKey = dotenv.get('API_KEY');
    resultId = getRandomElement(listForRandom);

    fetchMovies(
      "https://api.themoviedb.org/3/list/$resultId?api_key=$apiKey&language=en-US",
    );
    fetchGenre(
      "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US",
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    debug_print("random value: " + list[i].toString());
    return list[i];
  }

  Future<void> fetchMovies(url) async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        movies = jsonDecode(res.body)['items'];
        name = jsonDecode(res.body)['name'];
        fetchLoading = false;
      });
    }
  }

  Future<void> fetchGenre(url) async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        genres = jsonDecode(res.body)['genres'];
      });
    }
  }

  Future<void> refresh() {
    setState(() {
      resultId = getRandomElement(listForRandom);
    });
    EasyLoading.showToast(
      "Refresh movie list",
      toastPosition: EasyLoadingToastPosition.bottom,
    );
    return fetchMovies(
        "https://api.themoviedb.org/3/list/$resultId?api_key=$apiKey&language=en-US");
  }

  setDetail(index) {
    setState(() {
      genresString = [];
      adult = movies[index]['adult'];
      backdropPath = movies[index]['backdrop_path'];
      originalTitle = movies[index]['original_title'];
      originalLanguage = movies[index]['original_language'];
      overview = movies[index]['overview'];
      popularity = movies[index]['popularity'];
      posterPath = movies[index]['poster_path'];
      releaseDate = movies[index]['release_date'];
      voteAverage = movies[index]['vote_average'];
      voteCount = movies[index]['vote_count'];
      genresList = movies[index]['genre_ids'];
    });

    for (int genreIndex = 0; genreIndex < genres.length; genreIndex++) {
      if (genresList.contains(genres[genreIndex]['id'])) {
        setState(() {
          genresString.add(genres[genreIndex]['name']);
        });
      }
    }
  }

  getGenres() {
    for (int index = 1; index <= genres.length; index++) {}
  }

  Widget loadImage(index, path) {
    return Image.network(
      "https://image.tmdb.org/t/p/w500${movies[index]['$path']}",
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  openDetailMovie(index) {
    setDetail(index);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMovie(
          genres: genresString,
          adult: adult,
          backdropPath: backdropPath,
          originalTitle: originalTitle,
          originalLanguage: originalLanguage,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          voteCount: voteCount,
        ),
      ),
    );
  }

  Widget createCard(int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openDetailMovie(index);
        },
        child: Column(
          children: [
            ClipRRect(
              child: loadImage(index, 'backdrop_path'),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[index]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Text(
                      movies[index]['release_date'] ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    movies[index]['overview'] ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView() {
    return RefreshIndicator(
      onRefresh: () {
        return refresh();
      },
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return createCard(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fetchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              title: InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () => EasyLoading.showToast(
                  name,
                  toastPosition: EasyLoadingToastPosition.bottom,
                  duration: const Duration(
                    seconds: 5,
                  ),
                ),
              ),
            ),
          ];
        },
        body: createListView(),
      ),
    );
  }
}
