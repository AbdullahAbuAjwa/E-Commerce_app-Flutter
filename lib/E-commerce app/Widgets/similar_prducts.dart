import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/single_product.dart';

class SimilarProducts extends StatefulWidget {
  final int id;
  final catName;

  const SimilarProducts(this.id, this.catName);

  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          child: const Text(
            'Similar Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          padding: EdgeInsets.all(12),
        ),
        Flexible(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Products')
                .where('cat_name', isEqualTo: widget.catName.toString())
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var docs = snapshot.data.documents;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: docs[index]['id'] == widget.id
                        ? null
                        : SingleProduct(
                            docs[index]['id'],
                            docs[index]['name'],
                            docs[index]['image'],
                            docs[index]['old_price'],
                            docs[index]['price'],
                            docs[index]['cat_name'],
                            docs[index]['description'],
                            key: ValueKey(docs[index].documentID),
                          ),
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
