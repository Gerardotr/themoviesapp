import 'package:flutter/material.dart';
import 'package:moviesapp/src/models/movie_model.dart';

class MovieHorizontalInfo extends StatelessWidget {
  final List<Movie> movies;

  final Function siguientePagina;

  MovieHorizontalInfo({required this.movies, required this.siguientePagina});

  final _pageCtrl = new PageController(
    initialPage: 1,
    viewportFraction: 0.6,
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
    Size size = MediaQuery.of(context).size;
    movie.uniqueId =
        '${movie.id}-${DateTime.now().millisecondsSinceEpoch.toString()}-poster';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xff45545d), borderRadius: BorderRadius.circular(8)),
        width: size.width * 0.2,
        child: Row(
          children: [
            Hero(
              tag: movie.uniqueId ?? '1',
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    movie.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    movie.releaseDate ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    movie.overview ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
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
            ),
            Text(
              'Hla',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
