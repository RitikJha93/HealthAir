import 'dart:convert';
// import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recase/recase.dart';

class SymptomPage extends StatefulWidget {
  const SymptomPage({Key? key}) : super(key: key);

  @override
  State<SymptomPage> createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  var response;
  var symptom;
  bool x=false;
  List<bool> val = [];
  Future getSymptoms() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token'
    };
    final url =
        'https://health-care-backend.vercel.app/api/symptom/getAllSymptoms';
    try {
      print('aaya?');
      final resp = await http.get(Uri.parse(url), headers: header);
      // print(jsonDecode(resp.body));
      response = jsonDecode(resp.body);
      setState(() {
        symptom = response[0]['symptoms'] as List;
        val = List.filled(symptom.length, false);
      });
      // print(response[0]['symptoms']);
      // print(response);
    } catch (err) {
      print(err);
    }
  }
  var FilteredSearch;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSymptoms();
    setState(() {
      FilteredSearch=symptom;
    });
    ReCase rc =  ReCase('Just_someSample-text');
  }

  void filtersearch(String query){
    setState((){
      FilteredSearch = symptom.where((e)=>e.toLowerCase().contains(query.toLowerCase())).toList();
    });
    print(FilteredSearch);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: x?Material(child: TextField(onChanged: (value){
          filtersearch(value);
        },),):IconButton(
          onPressed: () {
            setState(() {
              x=!x;
            });
          },
          icon: Icon(Icons.search),
        ),
      ),
      // backgroundColor: ,
      body: SafeArea(
          child: Column(
        children: [
          // AutoSizeText('data')
          SizedBox(
            height: size.height * 0.78,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Checkbox(
                      value: val[index],
                      onChanged: (value) {
                        setState(() {
                          val[index] = !val[index];
                        });
                      }),
                  AutoSizeText(symptom[index])
                ],
              );
            }),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Submit'))
        ],
      )),
    );
  }
}
