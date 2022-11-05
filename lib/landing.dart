// import 'package:adv_egg/emailLogin.dart';
import 'package:flutter/material.dart';

import 'emailLogin.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blue
            // image: DecorationImage(
            //     image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hi there 👋',
                    style: TextStyle(fontSize: 30
                      // fontSize: size.width*0.5
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''Welcome''',
                    style: TextStyle(fontSize: 45
                      // fontSize: size.width*0.5
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.55,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const EmailLogin(isDoctor: false,link: 'https://health-care-backend.vercel.app/api/user/login',)));
                        },
                        style: ButtonStyle(

                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text('Login as User'), Text('-->')],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: >)
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const EmailLogin(isDoctor: true,link: '',)));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text('Login as Doctor'), Text('-->')],
                        ))),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
