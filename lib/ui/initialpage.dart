import 'dart:async';

import 'package:ecommerceproject/const/appcolor.dart';
import 'package:ecommerceproject/ui/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Initialpage extends StatefulWidget {
  const Initialpage({ Key? key }) : super(key: key);

  @override
  _InitialpageState createState() => _InitialpageState();
}

class _InitialpageState extends State<Initialpage> {
  void initState(){
  Timer(Duration(seconds: 1), ()=>Navigator.push(context,
  MaterialPageRoute(builder:(_)=> Loginscreen())));
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appcolor.mycolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("E-App",style: TextStyle(
              color: Colors.white,
              fontSize: 44.sp,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 20.h,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )

          ],
        ),
      ),

    );
  }
}