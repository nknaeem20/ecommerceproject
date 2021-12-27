import 'package:ecommerceproject/const/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                child: Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: "Search Here",
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                            ),
                        )
                      ),
                    ),
                    ),
                    Container(
                  color: appcolor.mycolor,
                  height: 50.h,
                  width: 50.w,
                  child: Icon(Icons.search,color: Colors.grey),
                )
                  ],
                ),
              ),
              
            ],
          ),
      ))
    );
  }
}