import 'package:flutter/material.dart';

class DetailMovie extends StatelessWidget {
  final String original_title,
      original_language,
      overview,
      poster_path,
      release_date;
  final dynamic vote_average, popularity, vote_count;

  const DetailMovie({
    required this.original_title,
    required this.original_language,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.vote_count,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Card(
                child: Row(
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500$poster_path',
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              original_title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Popularity: $popularity",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Vote count: $vote_count",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
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
                                  "$vote_average",
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
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overview,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
