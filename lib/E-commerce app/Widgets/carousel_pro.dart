import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarouselPro extends StatefulWidget {
  @override
  _CarouselProState createState() => _CarouselProState();
}

class _CarouselProState extends State<CarouselPro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/m6.jpg'),
          AssetImage('assets/images/w3.jpeg'),
          AssetImage('assets/images/m1.jpeg'),
          AssetImage('assets/images/m4.png'),
          AssetImage('assets/images/w4.jpeg'),
          AssetImage('assets/images/m5.jpg'),
        ],
        autoplay: true,
        dotSize: 5,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 2000),
        dotBgColor: Colors.transparent,
        //   showIndicator: false,
      ),
    );
  }
}
