import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/ui/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'send_or_update_data_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showDetailedView(String makanan, String resep) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informasi Detail'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Makanan: $makanan'),
              Text('Resep: $resep'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SendOrUpdateData()),
          );
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Resep',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      drawer: const Sidemenu(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('resep').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final makanan = streamSnapshot.data!.docs[index]['makanan'];
                    final resep =
                        streamSnapshot.data!.docs[index]['resep'].toString();

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 11),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    makanan,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    resep,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    // Call the method to show the detailed view in a modal
                                    _showDetailedView(makanan, resep);
                                  },
                                  child: const Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
                                    size: 21,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SendOrUpdateData(
                                        makanan: makanan,
                                        resep: resep,
                                        id: streamSnapshot.data!.docs[index]
                                            ['id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 21,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final docData = FirebaseFirestore.instance
                                      .collection('resep')
                                      .doc(streamSnapshot.data!.docs[index]
                                          ['id']);
                                  await docData.delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade900,
                                  size: 21,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                )
              : Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}
