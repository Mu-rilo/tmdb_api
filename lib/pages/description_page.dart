import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb/widgets/release_date.dart';
import 'package:http/http.dart' as http;

class Description_Page extends StatefulWidget {
  final String name, description, banner, vote, launch;
  final int id;

  const Description_Page(
      {super.key,
      required this.id,
      required this.name,
      required this.description,
      required this.banner,
      required this.launch,
      required this.vote});

  @override
  State<Description_Page> createState() => _Description_PageState();
}

class _Description_PageState extends State<Description_Page> {
  //
  List popular = [];
  int page = 1;

  //

  //
  fetch() async {
    const String apiKey = '';
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.id}/similar?api_key=$apiKey&language=pt-BR&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        popular = json.decode(response.body)['results'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191826),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                child: Image.network(
                  widget.banner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FavoriteButton(
                  valueChanged: (_isFavorite) {
                    print('Is Favorite $_isFavorite)');
                  },
                  iconColor: Colors.green,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 13, bottom: 10),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.vote,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      Release_Date(
                          date: DateTime.now(), dateFormat: widget.launch),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 160),
                  child: Text(
                    'Opções Semelhantes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: popular.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      if(popular.length == Null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Description_Page(
                                vote: popular[index]['vote_count'].toString(),
                                id: popular[index]['id'],
                                name: popular[index]['title'],
                                description: popular[index]['overview'],
                                banner: 'https://image.tmdb.org/t/p/w500' +
                                    popular[index]['backdrop_path'],
                                launch: popular[index]['release_date'],
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w220_and_h330_face/' +
                              popular[index]['poster_path'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
