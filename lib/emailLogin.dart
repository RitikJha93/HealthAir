// import 'package:adv_egg/patient_login.dart';
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 's';
import 'package:http/http.dart' as http;
import 'package:healthcare/regScreen.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key,required this.isDoctor,required this.link});
  final bool isDoctor;
  final String link;
  // const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  var resp;
  Future login()async{
    try{
      print(email);
      print(password);
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      };
      print(widget.link);
      final response=await http.post(Uri.parse(widget.link),headers: header,body: jsonEncode(
          {'email': email, 'password': password}));

      resp=jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return response.statusCode;
    }catch(err){
      print(err);
    }
  }
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Login with your E-mail',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Material(
              // elevation: 20,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  obscureText: false,
                  onChanged: (value) {
                    setState(() {
                      email=value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),

                    //   hintStyle: TextStyle(color:Colors.black),
                    hintText: 'Enter your Email',
                    // icon: Icon(Icons.lock)
                  ),
                  style: const TextStyle(
                    // color:Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Material(
              // elevation: 20,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password=value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),

                    //   hintStyle: TextStyle(color:Colors.black),
                    hintText: 'Enter your password',
                    // icon: Icon(Icons.lock)
                  ),
                  style: const TextStyle(
                    // color:Colors.white
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: ()async {
                    if((email!=null||email!='')&&(password!=null&&password!='')){
                      try{
                        print(password);
                        print(email);
                        var re=await login();
                        if(re==201){
                          print('hey');
                          // Obtain shared preferences.
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('token', resp['token']);
                          prefs.setString('email', resp['email']);
                          prefs.setString('name', resp['name']);
                          prefs.setString('id', resp['_id']);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
                        }
                      }catch(err){
                        print(err);
                      }
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const PatientLogin()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50))),
                  child: const Text(
                    'Login',
                  ),
                ),
              ),
            ),
            if(!widget.isDoctor)Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?',
                      style: TextStyle(color: Colors.black38)),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>RegScreen()));


                  }, child: const Text('Sign up'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
