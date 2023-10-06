import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendOrUpdateData extends StatefulWidget {
  final String makanan;
  final String resep;
  final String id;
  const SendOrUpdateData({this.makanan = '', this.resep = '', this.id = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController makananController = TextEditingController();
  TextEditingController resepController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    makananController.text = widget.makanan;
    resepController.text = widget.resep;
    super.initState();
  }

  @override
  void dispose() {
    makananController.dispose();
    resepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Send Data',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Makanan',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: makananController,
              decoration: InputDecoration(hintText: 'tulis makanan'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Resep',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: resepController,
              decoration: InputDecoration(hintText: 'resep'),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (makananController.text.isEmpty ||
                    resepController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fill in all fields')));
                } else {
                  //reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('resep')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'makanan': makananController.text,
                    'resep': int.parse(resepController.text),
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                    //create document and write data to firebase
                    await dUser.set(jsonData).then((value) {
                      makananController.text = '';
                      resepController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      makananController.text = '';
                      resepController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.blue.shade400,
              child: showProgressIndicator
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
