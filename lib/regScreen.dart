// import 'package:adv_egg/patient_login.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/otpPage.dart';
import 'package:http/http.dart' as http;
class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  // const EmailLogin({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  var res;
  Future regUser()async{
    final url='https://health-care-backend.vercel.app/api/user/';
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token'
    };
    try{
      final respo=await http.post(Uri.parse(url),headers:header,body: jsonEncode(
          {'name':name,'email':email,'password':password}));
      if(respo!=200){
      }
      // print(respo.body);
      return respo.statusCode;
    }catch(err){
      print('madarchodddddddd');
      print(err);
    }
  }
  String? email;
  String? name;
  String? password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/bg1.jpg',
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height*0.04,),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Register Now!',
                  style: TextStyle(fontSize: 30),
                ),
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

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Name',
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
                        name=value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      //   hintStyle: TextStyle(color:Colors.black),
                      hintText: 'Enter your Name',
                      // icon: Icon(Icons.lock)
                    ),
                    style: const TextStyle(
                      // color:Colors.white
                    ),
                  ),
                ),
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
                      hintText: 'Enter your Password',
                      // icon: Icon(Icons.lock)
                    ),
                    style: const TextStyle(
                      // color:Colors.white
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () async{
                      if((name!=''||name!=null)&&(email!=''||email!=null)&&(password!=''||password!=null)){
                        var resp=await regUser();
                        if(resp==200){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OtpScreen()));
                        }
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const PatientLogin()));
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OtpScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50))),
                    child: const Text(
                      'Register',
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
