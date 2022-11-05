import 'package:flutter/material.dart';
import 'package:healthcare/HomePage.dart';
import 'package:healthcare/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? finalEmail;
  Future getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final obtainedEmail = prefs.get('email');
    setState(() {
      finalEmail = obtainedEmail as String?;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: finalEmail!=null?HomePage():LandingPage(),
    );
  }
}

