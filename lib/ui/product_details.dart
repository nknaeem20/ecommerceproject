import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerceproject/const/appcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  @override
  var _dotPosition = 0;
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users_cart_items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product_name"],
      "price": widget._product["product_price"],
      "image": widget._product["pimg"],
    }).then((value) => print("Add to cart"));
  }

  Future addTofavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users_favorite_items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product_name"],
      "price": widget._product["product_price"],
      "image": widget._product["pimg"],
    }).then((value) => print("Add to Favorite"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        )),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color:appcolor.mycolor,
            size: 35,
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users_favorite_items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("name", isEqualTo: widget._product['product_name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: appcolor.mycolor,
                  child: IconButton(
                      onPressed: () => snapshot.data.docs.length == 0
                          ? addTofavourite()
                          : Fluttertoast.showToast(msg: "Already Added"),
                      icon: snapshot.data.docs.length == 0
                          ? Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.white,
                            )),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: CarouselSlider(
                  items: widget._product["pimg"]
                      .map<Widget>((item) => Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fitWidth))),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: DotsIndicator(
                  dotsCount:
                      widget._product.length == 0 ? 1 : widget._product.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor:appcolor.mycolor,
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                    color: appcolor.mycolor.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "\৳ ${widget._product['product_price'].toString()}",
                    style: TextStyle(fontSize: 35.sp),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                      onPressed: () => addToCart(), child: Text("Add To Cart"),
                      ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget._product['product_name'],
                  style: TextStyle(fontSize: 25.sp)),
              SizedBox(
                height: 10,
              ),
              Text(widget._product['product_description']),
                      ],
                    ),
            )),
      ),
    );
  }
}