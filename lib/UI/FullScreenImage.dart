import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final imagePath;
  FullScreenImage(this.imagePath);

  final LinearGradient backgroundGradien = LinearGradient(colors: [
    Color(0x1000000),
    Color(0x3000000),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradien
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: imagePath, 
                  child: Image.network(imagePath)
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(Icons.close), 
                        onPressed: () {
                          Navigator.pop(context);
                        }
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
