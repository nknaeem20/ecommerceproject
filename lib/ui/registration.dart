import 'package:ecommerceproject/const/appcolor.dart';
import 'package:ecommerceproject/const/custombutton.dart';
import 'package:ecommerceproject/ui/loginscreen.dart';
import 'package:ecommerceproject/ui/userform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Registration extends StatefulWidget {
  const Registration({ Key? key }) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formkeys = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character')
  ]);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  signUp() async {
    try {
  UserCredential userCredential = 
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  );
  var authCredential=userCredential.user;
  print(authCredential!.uid);
  if (authCredential.uid.isNotEmpty){
    Navigator.push(context,
    MaterialPageRoute(builder: (_)=>UserForm()));
  }
  else {Fluttertoast.showToast(msg: "Something went wrong!");}
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    Fluttertoast.showToast(msg: "The password provided is too weak.");
    // print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    Fluttertoast.showToast(msg: "The account already exists for that email.");
    // print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }
  @override
  Widget build(BuildContext context) {
    String password;
    return Scaffold(
      backgroundColor: appcolor.mycolor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    // IconButton(
                    //   onPressed: null,
                    //   icon: Icon(
                    //     Icons.light,
                    //     color: Colors.transparent,
                    //   ),
                    // ),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formkeys,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Welcome To Sign Up",
                            style: TextStyle(
                                fontSize: 22.sp, color: appcolor.mycolor),
                          ),
                          Text(
                            "Glad to see you.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.w,
                                decoration: BoxDecoration(
                                    color: appcolor.mycolor,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Center(
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: EmailValidator(
                                        errorText: "Enter a valid email"),
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "Enter your email address",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF414041),
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: appcolor.mycolor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.w,
                                decoration: BoxDecoration(
                                    color: appcolor.mycolor,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Center(
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: passwordValidator,
                                    onChanged: (val) => password = val,
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: "Password must be 8 character long",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF414041),
                                    ),
                                    labelText: 'Enter Password',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: appcolor.mycolor,
                                    ),
                                    suffixIcon: _obscureText == true
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              size: 20.w,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.visibility_off,
                                              size: 20.w,
                                            )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 10.h,),
                          // Row(
                          //   children: [
                          //     Container(
                          //       height: 48.h,
                          //       width: 41.w,
                          //       decoration: BoxDecoration(
                          //           color: appcolor.mycolor,
                          //           borderRadius: BorderRadius.circular(12.r)),
                          //       child: Center(
                          //         child: Icon(
                          //           Icons.lock_outline,
                          //           color: Colors.white,
                          //           size: 20.w,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 10.w,
                          //     ),
                          //     Expanded(
                          //       child: TextField(
                                  
                                  
                          //         decoration: InputDecoration(
                          //           hintText: "Password must be 6 character",
                          //           hintStyle: TextStyle(
                          //             fontSize: 14.sp,
                          //             color: Color(0xFF414041),
                          //           ),
                          //           labelText: 'Confirm Password',
                          //           labelStyle: TextStyle(
                          //             fontSize: 15.sp,
                          //             color: appcolor.mycolor,
                          //           ),
                          //           // suffixIcon: _obscureText == true
                          //           //     ? IconButton(
                          //           //         onPressed: () {
                          //           //           setState(() {
                          //           //             _obscureText = false;
                          //           //           });
                          //           //         },
                          //           //         icon: Icon(
                          //           //           Icons.remove_red_eye,
                          //           //           size: 20.w,
                          //           //         ))
                          //           //     : IconButton(
                          //           //         onPressed: () {
                          //           //           setState(() {
                          //           //             _obscureText = true;
                          //           //           });
                          //           //         },
                          //           //         icon: Icon(
                          //           //           Icons.visibility_off,
                          //           //           size: 20.w,
                          //           //         )),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                    
                    
                          SizedBox(
                            height: 50.h,
                          ),
                          // elevated button
                          // SizedBox(
                          //   width: 1.sw,
                          //   height: 56.w,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       if (_formkeys.currentState!.validate()) {
                          //       return signup();
                          //     }
                          //     },
                          //     child: Text(
                          //       "SIGN UP",
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 18.sp),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //         primary: appcolor.mycolor, elevation: 3),
                          //   ),
                          // ),
                          customButtons("Sign Up", () {
                              if (_formkeys.currentState!.validate()) {
                                return signUp();
                              }
                            }),
                          SizedBox(
                            height: 20.h,
                          ),
                          Wrap(
                            children: [
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBBBBBB),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  " SIGN IN",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: appcolor.mycolor,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Loginscreen()));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}