import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/product_screen.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          child: Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          padding: EdgeInsets.only(top: 12, left: 10),
        ),
        Container(
          height: 100.0,
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Categories')
                .orderBy('name')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              var docs = snapshot.data.documents;
              return ListView.builder(
                itemCount: docs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryItem(
                    imageLocation: docs[index]['image'],
                    imageCaption: docs[index]['name'],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String imageLocation;
  final String imageCaption;

  CategoryItem({this.imageLocation, this.imageCaption});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProductScreen(widget.imageCaption.toString());
          }));
        },
        child: Container(
          width: 95.0,
          child: ListTile(
              title: SvgPicture.network(
                widget.imageLocation,
                width: 95.0,
                height: 70.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.imageCaption,
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
