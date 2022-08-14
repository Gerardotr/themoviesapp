import 'package:flutter/material.dart';
import 'package:moviesapp/src/models/movie_model.dart';
import 'package:moviesapp/src/widgets/horizontal_swiper_single.dart';

import '../providers/auth_provider.dart';
import '../providers/movie_provider.dart';
import '../search/search.dart';
import '../widgets/card_swiper_widget.dart';
import '../widgets/horizontal_swiper.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();
  final authService = AuthProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        backgroundColor: Color(0xFF22223b),
        appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_circle_right_outlined),
                onPressed: () {
                  _logout(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearch(), query: '');
                },
              ),
            )
          ],
          title: Container(
            child: Row(children: [
              CircleAvatar(
                child: Image.asset('assets/img/man.png'),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gerardo Ramos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Gerardo Ramos',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ],
                  ))
            ]),
          ),
          backgroundColor: Color(0xFF22223b),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTargetas(),
              _slideSingleInfoMovie(context),
              _footer(context)
            ],
          ),
        ));
  }

  Widget _swiperTargetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.hasData);

          return CardSwiper(movies: snapshot.data!);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _slideSingleInfoMovie(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
              child: Text('Upcoming',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontalInfo(
                  movies: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
           padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
              child:Text('Popular',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  _logout(context) {
    this.authService.logout();

    Navigator.pushReplacementNamed(context, '/');
  }
}
