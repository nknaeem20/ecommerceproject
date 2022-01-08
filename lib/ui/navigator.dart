import 'package:ecommerceproject/const/appcolor.dart';
import 'package:ecommerceproject/navigator/addtocart.dart';
import 'package:ecommerceproject/navigator/favorite.dart';
import 'package:ecommerceproject/navigator/homepage.dart';
import 'package:ecommerceproject/navigator/profile.dart';
import 'package:flutter/material.dart';
class Homewidget extends StatefulWidget {
  const Homewidget({ Key? key }) : super(key: key);

  @override
  _HomewidgetState createState() => _HomewidgetState();
}

class _HomewidgetState extends State<Homewidget> {
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label:"Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
        ],
        
        onTap: (index){
          setState(() {
            indexpage = index;
          });
        },
        fixedColor: appcolor.mycolor,
        ),
        body: page[indexpage],
      ),
      
    );
  }
}