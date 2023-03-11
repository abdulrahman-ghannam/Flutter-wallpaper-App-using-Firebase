import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdgnashik_gallery/UI/FullScreenImage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Create a subscription to Continous update UI Images
  StreamSubscription<QuerySnapshot> subscription;

  // Create list of type DocumentSnapshot
  List<DocumentSnapshot> imageList;

  //Create instance Firestore  
  // Create Refernce of CollectionReference
  final CollectionReference collectionReference =
      Firestore.instance.collection("images");


  // Init Method 
  @override
  void initState() {
    super.initState();
    // add listener 
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        imageList = datasnapshot.documents;
      });
    });
  }


  // dispose Method 
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Images"),
        ),
        body: imageList != null
            ? StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  String imagePath = imageList[index].data['url'];
                  return Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(12.0),
                    child: GestureDetector(
                      onTap: () {
                        print("Button Press");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImage(imagePath)));
                      },
                      child: Hero(
                          tag: imagePath,
                          child: FadeInImage(
                            placeholder: AssetImage("images/pic1.jpg"),
                            image: NetworkImage(imagePath),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
