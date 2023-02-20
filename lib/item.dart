import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Cutomerupload.dart';
import 'itemupload.dart';





class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);
  @override
  State<Item> createState() => _ItemState();
}
class _ItemState extends State<Item> {




  @override
  get Item=>FirebaseFirestore.instance.collection
    ('Item').
  snapshots();

  void initState() {
    CollectionReference Item = FirebaseFirestore.instance.
    collection('Item');
    super.initState();
  }
  Future deleteUser(id)async {
    FirebaseFirestore.instance
        .collection("Item")
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('failed to delete Product:$error'));


    //print("User Deleted $id");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:Item,
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
                title: Text('Item'),
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
                                        Text(produt.get('code').toString(),style: TextStyle(fontSize: 15),),
                                        Align(

                                            alignment: Alignment.topLeft,
                                            child: Text('Rs'+produt.get('price').toString()+'/-',style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                    //   trailing: Text('Rs '+product.get('date').+'/-',style: TextStyle(fontSize: 15),),
                                    onTap: (){
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Orderdetails(produt) ));
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
                                    builder: (context) =>Itempanel()));
                          },
                          //  icon: Icon(Icons.directions_bike),
                          label: Text('Upload '),
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
