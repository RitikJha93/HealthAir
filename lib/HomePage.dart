import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthcare/card.dart';
import 'package:healthcare/fetchAllDocs.dart';
import 'package:healthcare/symptomPage.dart';
// import 'package:healthcare/newsCard.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  var news;
  var respo;
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
      backgroundColor: Colors.amber.shade100,
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' My Course '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: size.height*0.05),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                'Hey There! Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            AutoSizeText(
              'Here are our top rated doctors',
              style: TextStyle(fontSize: 25),
            ),
            Container(
              height: 125,
              // width: ,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return CardView();
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
                    'Here are some of the blogs you can read:',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Container(
              height: size.height*0.5,
              child: ListView.builder(
                  // itemCount: respo['totalResults'],
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    print(news[index]['title']);
                    return Card(elevation: 10,child: Container(
                      height: 125,
                      width: size.width,
                      child: Column(
                        children: [
                          Image.network(news[index]['urlToImage'].toString(),height: 70,width: size.width,),
                          Column(
                            children: [
                              AutoSizeText(
                                maxLines:1,
                                news[index]['title'].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                              ),AutoSizeText(
                                maxLines:2,
                                news[index]['description'].toString(),
                                style: TextStyle(fontSize: 15),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ));
                  }),
            )
          ],
        ),
      )),
    );
  }
}
