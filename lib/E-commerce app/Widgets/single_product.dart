import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/product_details.dart';

class SingleProduct extends StatelessWidget {
  final id;
  final prodName;
  final prodPicture;
  final prodOldPrice;
  final prodPrice;
  final catName;
  final description;

  final Key key;

  SingleProduct(this.id, this.prodName, this.prodPicture, this.prodOldPrice,
      this.prodPrice, this.catName, this.description,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProductDetailsScreen(
              id,
              prodName,
              prodOldPrice,
              prodPrice,
              prodPicture,
              catName,
              description,
            );
          }));
        },
        child: GridTile(
            footer: Container(
              height: 55,
              color: Color(0xFFEEEEEE),
              child: ListTile(
                leading: Container(
                  width: 100,
                  child: Text(
                    prodName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  "\$$prodPrice",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  prodOldPrice == null ? '' : "\$$prodOldPrice",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
            ),
            child: Image.network(
              prodPicture,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
