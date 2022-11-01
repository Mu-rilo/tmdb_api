import 'package:flutter/material.dart';
import 'package:tmdb/Home_Screen.dart';
import 'package:tmdb/pages/description_page.dart';

class MoviePage extends StatefulWidget {
  final List popular;
  final ScrollController controller;

  const MoviePage({
    super.key,
    required this.popular,
    required this.controller,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: widget.controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: 0.66,
        ),
        itemCount: widget.popular.length,
        itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Description_Page(
                            vote: widget.popular[index]['vote_count']
                                .toString(),
                            id: widget.popular[index]['id'],
                            name: widget.popular[index]['title'],
                            description: widget.popular[index]['overview'],
                            banner: 'https://image.tmdb.org/t/p/w500' +
                                widget.popular[index]['backdrop_path'],
                            launch: widget.popular[index]['release_date'],
                          ),
                    ),
                  );
                },
                child: Image.network(
                  'https://image.tmdb.org/t/p/w220_and_h330_face/' +
                      widget.popular[index]['poster_path'],
                  fit: BoxFit.cover,
                )
            );
        }
        );
  }
}
