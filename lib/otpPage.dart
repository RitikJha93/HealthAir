import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/HomePage.dart';
import 'package:healthcare/emailLogin.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int? otp;
  Future<dynamic> checkOTP() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      var response = await http.post(
          Uri.parse('https://health-care-backend.vercel.app/api/user/validate/'),
          headers: header,
          body:
          jsonEncode({ "userOTP": otp}));
      // body=jsonDecode(response.body);
      // print(response.body);
      return (response.statusCode);
    } catch (e) {
      // print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText('Enter OTP sent to your mail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Material(
                elevation: 5,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // otp=int.parse(value);
                    setState(() {
                      otp=int.parse(value);
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter OTP',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextButton(
                    onPressed: () {}, child: AutoSizeText('Resend OTP')),
              ),
            ),
            ElevatedButton(onPressed: ()async{
              if(otp!=null||otp!=''){
                var res=await checkOTP();
                if(res!=201){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const EmailLogin(isDoctor: false, link: 'https://health-care-backend.vercel.app/api/user/login')));
                }
              }
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
            }, child: AutoSizeText('Submit'))
          ],
        ),
      ),
    );
  }
}
