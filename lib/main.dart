import 'package:flutter/material.dart';
import 'package:moviesapp/src/pages/details_page.dart';
import 'package:moviesapp/src/pages/inside2_page.dart';
import 'package:moviesapp/src/pages/insode_page.dart';
import 'package:moviesapp/src/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'src/shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = new PreferenciasUsuario();
  await _prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = PreferenciasUsuario();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: _prefs.token != '' ? 'inside' : '/',
      routes: {
        '/': (BuildContext context) => LoginPage(),
        'inside': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}
