import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/const/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  List<String> sliding_image = [];
  var _dotPosition = 0;
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchimage() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("slide_image_01").get();
    setState(() {
      for (var i = 0; i < qn.docs.length; i++) {
        sliding_image.add(qn.docs[i]["imgpath"]);
      }
    });
    return qn.docs;
  }

  void initState() {
    fetchimage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: "Search Here",
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: appcolor.mycolor,
                      height: 50.h,
                      width: 50.w,
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: sliding_image
                      .map((item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
                DotsIndicator(
                dotsCount:
                    sliding_image.length == 0 ? 1 : sliding_image.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: appcolor.mycolor,
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                  color: appcolor.mycolor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
