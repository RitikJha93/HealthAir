// import 'package:adv_egg/patient_login.dart';
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
  Future regUser()async{
    final url='http://192.168.144.74:5000/api/user/';
    try{

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
                    obscureText: true,
                    onChanged: (value) {
                      email = value;
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
                    obscureText: true,
                    onChanged: (value) {
                      email = value;
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
                      email = value;
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

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Confirm Password',
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
                      password = value;
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
              SizedBox(height: size.height*0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const PatientLogin()));
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OtpScreen()));
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
