import 'dart:convert';
// import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/detectedDisease.dart';
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
  var pred;
  var l1=[],l2=[];
  String s='';
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
  Future getPrediction()async{

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try{
      final url='https://ml-disease.up.railway.app/predict_prob/?symptoms=$s';
      final resp=await http.post(Uri.parse(url),headers: header);
      print(jsonDecode(resp.body));
      print(jsonDecode(resp.body)['final_prediction']);
      setState(() {
        pred=jsonDecode(resp.body)['final_prediction'];

      });
      Map o=pred;
      for(final mapEntry in o.entries){

        l1.add(mapEntry.value.toString());
        l2.add(mapEntry.key);
      }
      print(l2);
      print(resp.statusCode);
      return resp.statusCode;
    }catch(err){
      print(err);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSymptoms();
    // setState(() {
    //   FilteredSearch=symptom;
    // });
    l1=[];
    l2=[];
    ReCase rc =  ReCase('Just_someSample-text');
  }

  // void filtersearch(String query){
  //   setState((){
  //     FilteredSearch = symptom.where((e)=>e.toLowerCase().contains(query.toLowerCase())).toList();
  //   });
  //   print(FilteredSearch);
  // }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey,
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
          ElevatedButton(onPressed: () async{
            l1=[];
            l2=[];
            for(int i =0;i<val.length;i++){
              if(val[i]){
                setState(() {
                  s=symptom[i]+','+s;
                  // s=s.substring(0,s.length);
                  print(s);
                });
              }
            }
            if(s!=''){
              setState(() {
                s=s.substring(0,s.length-1);
                val = List.filled(symptom.length, false);
              });
              var b=await getPrediction();
              s='';
              if(b==200){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DetectedDisease(data:pred ,l1: l1,l2: l2,)));
                // l1=[];
                // l2=[];
              }

            }

          }, child: Text('Submit'))
        ],
      )),
    );
  }
}
