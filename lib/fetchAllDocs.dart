import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/DocAllDetails.dart';
import 'package:http/http.dart' as http;

class FetchAllDocs extends StatefulWidget {
  const FetchAllDocs({Key? key}) : super(key: key);

  @override
  State<FetchAllDocs> createState() => _FetchAllDocsState();
}

class _FetchAllDocsState extends State<FetchAllDocs> {
  var allDocs;
  Future getAllDocs() async {
    final url =
        'https://health-care-backend.vercel.app/api/doctor/getAllDoctors';
    try {
      final respo = await http.get(Uri.parse(url));
      setState(() {
        allDocs = jsonDecode(respo.body);
      });
      print(allDocs);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDocs();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Doctors'),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: allDocs.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DocAllDetails(
                              image: allDocs[index]['image'],
                              qualification: allDocs[index]['qualification'],
                              specialization: allDocs[index]['specialization'],
                              name: allDocs[index]['name'],
                              currentLocation: allDocs[index]
                                  ['currentLocation'])));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircularImage(
                                    radius: 75,
                                    // scale: 6,
                                    source: allDocs[index]['image'],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: AutoSizeText(
                                        allDocs[index]['name'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    AutoSizeText(
                                      allDocs[index]['qualification'],
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    AutoSizeText(
                                      allDocs[index]['specialization'],
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
