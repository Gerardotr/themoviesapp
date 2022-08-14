import 'package:flutter/material.dart';
import 'package:moviesapp/src/utils/constants.dart';

class Inside extends StatefulWidget {
  Inside({Key? key}) : super(key: key);

  @override
  State<Inside> createState() => _InsideState();
}

class _InsideState extends State<Inside> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22223b),
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.search),
          )
        ],
        title: Container(
          child: Row(children: [
            CircleAvatar(
              backgroundColor: Colors.white,
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
      body: Container(
          child: Center(
        child: Text('Hola'),
      )),
    );
  }
}
