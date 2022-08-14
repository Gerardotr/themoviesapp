import 'package:flutter/material.dart';
import 'package:moviesapp/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;

  final Function siguientePagina;

  MovieHorizontal({required this.movies, required this.siguientePagina});

  final _pageCtrl = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSise = MediaQuery.of(context).size;

    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >=
          _pageCtrl.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSise.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageCtrl,
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _targeta(context, movies[i]);
        },
        //children: _targetas(context),
      ),
    );
  }

  Widget _targeta(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-${DateTime.now().millisecondsSinceEpoch.toString()}-poster';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId ?? '2',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Hola',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: movie);
        print('ID de la pelicula ${movie.id}');
      },
    );
  }

  List<Widget> _targetas(BuildContext context) {
    return movies.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            )
          ],
        ),
      );
    }).toList();
  }
}
