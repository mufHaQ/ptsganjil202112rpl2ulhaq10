import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ptsganjil202112rpl2ulhaq10/pages/movie_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  bool loading = true;
  dynamic api_key, api_token, url;

  var original_title,
      original_language,
      overview,
      popularity,
      poster_path,
      release_date,
      vote_average,
      vote_count;

  int? id;
  bool? adult;

  @override
  void initState() {
    super.initState();
    api_key = dotenv.get('API_KEY');
    url = 'https://api.themoviedb.org/4/list/1?page=2&api_key=$api_key';
    fetchMovies(url);
  }

  Future<void> fetchMovies(url) async {
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      setState(() {
        movies = jsonDecode(res.body)['results'];
        loading = false;
      });
    }
  }

  setDetail(item, index) {
    setState(() {
      original_title = item[index]['original_title'];
      original_language = item[index]['original_language'];
      overview = item[index]['overview'];
      popularity = item[index]['popularity'];
      poster_path = item[index]['poster_path'];
      release_date = item[index]['release_date'];
      vote_average = item[index]['vote_average'];
      vote_count = item[index]['vote_count'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading || movies.contains(null) || movies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: SizedBox(
              height: 200,
              child: InkWell(
                onTap: () {
                  EasyLoading.showToast(
                    movies[index]['original_title'],
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                  setDetail(movies, index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMovie(
                        original_title: original_title,
                        original_language: original_language,
                        overview: overview,
                        popularity: popularity,
                        poster_path: poster_path,
                        release_date: release_date,
                        vote_average: vote_average,
                        vote_count: vote_count,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}",
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movies[index]['original_title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                movies[index]['overview'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.star),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${movies[index]['vote_average']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
