import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';
class Itempanel extends StatefulWidget {
  const Itempanel ({super.key});
  @override
  ItempanelState createState() {
    return ItempanelState();
  }
}
class ItempanelState extends State<Itempanel > {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var phone = "";





  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

//  final TextEditingController  _brandController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();


  final _auth = FirebaseAuth.instance;

  static String? get uid => null;

  @override
  void dispose() {
    // _brandController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  Future<void> addUser() async {


    CollectionReference Item = FirebaseFirestore.instance.
    collection('Item');
    Item.doc().set(
        {
          'name': name,
          'price': phone,
          'code': email,

        }).then((valure) => print('Product Added'))
        .catchError((error) => print('failed to add Product:$error'));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Sellpanelupload()));

  }



  clearText() {
    //  _brandController.clear();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();

  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(

        appBar: AppBar(

          title: Text('Upload '),
          backgroundColor:Colors.blue,

        ),

        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [



                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,

                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Enter Costomer Name',
                        hintStyle: const TextStyle(
                            height: 2, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,

                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter code',
                          hintStyle: const TextStyle(
                              height: 2, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  codename';
                        }
                        return null;
                      },

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      controller: _phoneController,

                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Enter Price',
                        hintStyle: const TextStyle(
                            height: 2, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Enter number';
                        }
                        return null;
                      },
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.blue),
                      ),
//color: Color.fromRGBO(100, 0, 0, 10),

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = _nameController.text;
                            email = _emailController.text;
                            phone = _phoneController.text;


                            //  url=_imageController.text;
                            // py=_pyController.text;
                            // pr=_prController.text;
                            // _uploadImage();
                            addUser();
                            clearText();

                            Fluttertoast.showToast(msg: "Uploaded");
                            // Navigator.of(context).pop(Sellpanelupload);
                          });
                        }
                      },
                      child: Text("Uploaded"),

                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }




}
