import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviesapp/src/pages/insode_page.dart';
import 'package:moviesapp/src/pages/login_page.dart';
import 'package:moviesapp/src/shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer(Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(SecondPageRoute()));

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22223b),
      body: Center(
        child: Lottie.asset(
          'assets/lottie/83714-prime-video-intro.json',
        ),
      ),
    );
  }
}

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute()
      : super(builder: (BuildContext context) {
          final prefs = PreferenciasUsuario();
          return prefs.token != '' ? HomePage() : LoginPage();
        });
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final prefs = PreferenciasUsuario();
    return FadeTransition(
        opacity: animation,
        child: prefs.token != '' ? HomePage() : LoginPage());
  }
}
