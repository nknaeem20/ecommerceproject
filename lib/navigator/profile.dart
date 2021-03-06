import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Profilewidget extends StatefulWidget {
  const Profilewidget({Key? key}) : super(key: key);

  @override
  _ProfilewidgetState createState() => _ProfilewidgetState();
}

class _ProfilewidgetState extends State<Profilewidget> {
  File? image;
  final picker = ImagePicker();

  getImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedImage!.path);
    });
  }
  Future profileImageset() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("profile_image");

    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "profileimage": image!.path,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => Profilewidget())))
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;
  SetDataToTextField(data) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          controller: _nameController =
              TextEditingController(text: data['name']),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          controller: _phoneController =
              TextEditingController(text: data['phone']),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: () => updateData(), child: Text("Update"))
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users_form_data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "phone": _phoneController!.text,
      "age": _ageController!.text,
    }).then((value) => Fluttertoast.showToast(msg: "Updated Successfully"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   child: Image.file(image!),
                  // ),
                  
                  Stack(
                    children: [
                      image == null
                          ? Center(child: Text(""))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(125),
                              child: Image.file(
                                image!,
                                height: 250,
                                width: 250,
                              ),
                            ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100,),
                          child: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: Icon(Icons.add_a_photo)),
                        ),
                      ),
                      // Positioned(
                      //     child: ElevatedButton(
                      //         onPressed: () {
                      //           profileImageset();
                      //         },
                      //         child: Text("Upload")))
                    ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users_form_data")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var data = snapshot.data;
                      if (data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SetDataToTextField(data);
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}