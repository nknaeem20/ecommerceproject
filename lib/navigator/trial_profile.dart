import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class TrialProfile extends StatefulWidget {

  @override
  _TrialProfileState createState() => _TrialProfileState();
}

class _TrialProfileState extends State<TrialProfile> {
  File? imageFile;

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
                  Container(
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.greenAccent,
                    onPressed: () {
                      _getFromGallery();
                    },
                    child: Text("PICK FROM GALLERY"),
                  ),
                  Container(
                    height: 40.0,
                  ),
                  RaisedButton(
                    color: Colors.lightGreenAccent,
                    onPressed: () {
                      _getFromCamera();
                    },
                    child: Text("PICK FROM CAMERA"),
                  )
                ],
              ),
            ): Container(
              child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
            )),
                  
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

_getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
         var imageFile = File(pickedFile.path);
      });
    }
  }

void setState(Null Function() param0) {
}

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
         var imageFile = File(pickedFile.path);
      });
    }
  }

