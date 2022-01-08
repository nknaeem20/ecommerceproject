import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerceproject/const/appcolor.dart';
import 'package:ecommerceproject/navigator/addtocart.dart';
import 'package:ecommerceproject/navigator/favorite.dart';
import 'package:ecommerceproject/navigator/homepage.dart';
import 'package:ecommerceproject/navigator/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CurveHomeWidget extends StatefulWidget {
  const CurveHomeWidget({ Key? key }) : super(key: key);

  @override
  _CurveHomeWidgetState createState() => _CurveHomeWidgetState();
}

class _CurveHomeWidgetState extends State<CurveHomeWidget> {
  @override
  var indexpage = 0;
  final page = [
    Homepage(),
    Favoritewidget(),
    Cartwidget(),
    Profilewidget(),
  ];
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor.mycolor,
          title: Center(child: Text("E-Commerce")),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          buttonBackgroundColor: appcolor.mycolor.withOpacity(0.5),
        items: [
          Container(
          child: Column(
            children: [Icon(Icons.home), Text("Home")],
          ),
        ),Container(
          child: Column(
            children: [Icon(Icons.favorite_border_outlined), Text("Favorite")],
          ),
        ),Container(
          child: Column(
            children: [Icon(Icons.shopping_cart), Text("Cart")],
          ),
        ),
          Container(
          child: Column(
            children: [Icon(Icons.person), Text("Profile")],
          ),
        ),
          
        ],
        onTap: (index){
          setState(() {
            indexpage = index;
          });
        },
        ),
        body: page[indexpage],
      ),
      
    );
  }
}