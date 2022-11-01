import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/pages/movie_page.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List popularMovies = [];
  int page = 1;

  //
  Future fetch() async {
    const String apiKey = '67ccb04828c7f32c706f63e51b751b72';
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=$page');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      setState(() {
      popularMovies = json.decode(response.body)['results'];
      });
    }
  }
  //


  //
  @override
  void initState() {
    super.initState();
    fetch();
    loadMoreMovies = ScrollController();
    loadMoreMovies.addListener(() async {
      if (loadMoreMovies.position.maxScrollExtent == loadMoreMovies.offset) {
        fetch();
        page+=1;
      }
    }
    );
  }
  //

  //

  @override
  void dispose() {
    loadMoreMovies.dispose();
    super.dispose();
  }
  //


  //controller para carregar a próxima page de filmes
  late ScrollController loadMoreMovies;
  //

  //resetando a main page para começar na primeira página de filmes
 Future<void> refresh() async{
   setState(() {
     page=1;
     fetch();
   });
 }
 //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191826),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'FILMES',
          style: TextStyle(
            fontSize: 25,
            color:  Color(0xfff43370)
          ),
        ),
      ),
      body:RefreshIndicator(
        onRefresh: refresh,
        child: MoviePage(
          popular: popularMovies,
          controller: loadMoreMovies,
          ),
      ),
    );
  }
}
