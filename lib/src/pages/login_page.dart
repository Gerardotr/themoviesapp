import 'dart:convert';

import 'package:flutter/material.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isloading = false;
  bool _passwordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordnController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  final authService = AuthProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = 'eve.holt@reqres.in';
    passwordnController.text = 'cityslicka';
    _passwordVisible = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // _prefs.ultimaPagina = 'login';
    return Scaffold(
      backgroundColor: Color(0xFF22223b),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                      width: size.width * 0.6,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Image(
                        image: AssetImage('assets/img/video-player.png'),
                        fit: BoxFit.contain,
                      )),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: "Correo",
                          labelStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordnController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: "Contraseña",
                          labelStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              height: 50,
                              width: double.infinity,
                              child: FlatButton(
                                onPressed: () {
                                  _login(emailController.text,
                                      passwordnController.text, context);
                                },
                                padding: EdgeInsets.all(0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.red),
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50),
                                    child: Text(
                                      "Iniciar Sesión",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login(String email, String password, BuildContext context) async {
    _isloading = true;
    setState(() {});

    if (email == null) {
      print(email);
    } else {
      Map info = await authService.login(email, password, context);

      if (info['ok']) {
        _isloading = false;
        setState(() {});
        print(info);
        Navigator.pushReplacementNamed(context, 'inside');
        // Navigator.pushReplacementNamed(context, 'tabs');
      } else {
        _isloading = false;
        setState(() {});
      }
    }
  }
}
