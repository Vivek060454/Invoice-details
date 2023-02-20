import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Cutomerupload.dart';
import 'linvoiceupload.dart';





class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);
  @override
  State<Invoice> createState() => _InvoiceState();
}
class _InvoiceState extends State<Invoice> {




  @override
  get Invoice=>FirebaseFirestore.instance.collection
    ('Invoice').
  snapshots();

  void initState() {
    CollectionReference Invoice = FirebaseFirestore.instance.
    collection('Invoice');
    super.initState();
  }
  Future deleteUser(id)async {
    FirebaseFirestore.instance
        .collection("Invoice")
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('failed to delete Product:$error'));


    //print("User Deleted $id");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:Invoice,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) async {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
              appBar: AppBar(
                title: Text('Invoice'),
                // backgroundColor: const Color.fromRGBO(100, 0, 0, 10),


              ),

              body:
              Center(
                  child:Column(
                    children: [


                      Expanded(
                        child: ListView.builder(
                            itemCount:   snapshot.data!.docs.length,

                            itemBuilder: (context,index){
                              final  produt = snapshot.data!.docs[index];

                              return Container(


                                child: Card(

                                  child:

                                  ListTile(

                                    title: Text(produt.get('customername'),style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                    subtitle: Column(
                                      children: [
                                        Text(produt.get('email').toString(),style: TextStyle(fontSize: 15),),
                                        Text(produt.get('phone').toString(),style: TextStyle(fontSize: 15),),
                                      ],
                                    ),
                                    //   trailing: Text('Rs '+product.get('date').+'/-',style: TextStyle(fontSize: 15),),
                                    onTap: (){
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Invoice() ));
                                    },
                                    trailing: InkWell(
                                        onTap:(){
                                          deleteUser(produt.id);
                                        },
                                        child: Icon(Icons.delete)),
                                  ),

                                ),


                              );


                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.blue,

                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => Invoicepanel()));
                          },
                          //  icon: Icon(Icons.directions_bike),
                          label: Text('Upload Bag'),
                        ),
                      ),
                    ],
                  )


              )

          );
        }
    );
  }
}
