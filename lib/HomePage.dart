import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_image/circular_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthcare/card.dart';
import 'package:healthcare/emailLogin.dart';
import 'package:healthcare/fetchAllDocs.dart';
import 'package:healthcare/landing.dart';
import 'package:healthcare/main.dart';
import 'package:healthcare/symptomPage.dart';
// import 'package:healthcare/newsCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    getNews();
    getAllDocs();
    getName();
  }

  var news;
  var respo;
  String? name;
  String? email;
  Future getName()async{
    final url=await SharedPreferences.getInstance();
    setState(() {
      email=url.getString('name');
      name=url.getString('email');
    });
  }
  Future getNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=c9082e34e82845e09e6f01addcd62106';
    try {
      print('init');
      var dio = Dio();

      respo = await http.get(Uri.parse(url));
      // print(respo.data);
      // respo=resp;
      // print('kuch hua kya?');
      // print(resp.statusCode);
      // print(jsonDecode(resp.body));
      final data = jsonDecode(respo.body);
      setState(() {
        respo = data;
        news = data['articles'];
      });
      print(news);
      print(news.length);
    } catch (err) {
      print('yaha??');
      // print(respo.statusCode);
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Predict Diseases',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SymptomPage()));
            }
          ),SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Consult a Doctor',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FetchAllDocs()));
            }
          ),
        ],
      ),
      drawer:Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(name!,
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email!),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    name![0],
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Past consultations'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async{
                final prefs=await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyApp()));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // SizedBox(height: size.height*0.05),


              Align(
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  'Top rated doctors',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                height: 250,
                // width: ,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allDocs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardView(image: allDocs[index]['image'],name: allDocs[index]['name'],specialization:allDocs[index]['specialization'],qualification:allDocs[index]['qualification']  ,);
                    }),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      'Recent Blogs:',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                height: size.height*0.7,
                child: ListView.builder(
                    // itemCount: respo['totalResults'],
                    scrollDirection: Axis.vertical,
                    itemCount: news.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(news[index]['title']);
                      return GestureDetector(
                        onTap: (){

                        },
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

                                    SizedBox(
                                      width:MediaQuery.of(context).size.width*0.5,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                news[index]['title'].toString(),
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              maxLines: 4,
                                              news[index]['description'].toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [

                                        if(news[index]['urlToImage']!=null)Image.network(
                                          width:150,
                                          height:100,

                                          // radius: 75,
                                          // scale: 6,
                                          news[index]['urlToImage'].toString(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      // return Card(elevation: 10,child: Container(
                      //   height: 125,
                      //   width: size.width,
                      //   child: Column(
                      //     children: [
                      //       Image.network(news[index]['urlToImage'].toString(),height: 70,width: size.width,),
                      //       Column(
                      //         children: [
                      //           AutoSizeText(
                      //             maxLines:1,
                      //             news[index]['title'].toString(),
                      //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                      //           ),AutoSizeText(
                      //             maxLines:2,
                      //             news[index]['description'].toString(),
                      //             style: TextStyle(fontSize: 15),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ));
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
