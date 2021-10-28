import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componentes/bodyMenu.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  double _aspectRatio = 2;
  int _crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              splashRadius: 24.0,
              icon: Icon(
                CupertinoIcons.command,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BodyMenu(),
    );
  }
}
