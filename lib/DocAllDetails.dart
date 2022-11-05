import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healthcare/chatScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DocAllDetails extends StatefulWidget {
  const DocAllDetails({Key? key,required this.docKaId,required this.image,required this.qualification,required this.specialization,required this.name,required this.currentLocation}) : super(key: key);
  final String image,qualification,specialization,name,currentLocation,docKaId;

  @override
  State<DocAllDetails> createState() => _DocAllDetailsState();
}


class _DocAllDetailsState extends State<DocAllDetails> {
  var name;
  var token;
  var newChat;
  Future createChat()async{
    final url='http:// 192.168.164.1:5000/api/chat';
    getName().whenComplete(() async{
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
        try{
        final res=await http.post(Uri.parse(url),headers:header,body: ({
          'userId':widget.docKaId
        }) );
        setState(() {
          newChat=jsonDecode(res.body);
        });

        }catch(err){
      print(err);
    }
    });

  }

  Future postFirstMessage() async{
    final url='http:// 192.168.164.1:5000/api/message';
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try{
      final resp=await http.post(Uri.parse(url),headers: header,body: ({
        'id':widget.docKaId,
        'content':'Thanks for Consulting! $name, for further detailed assessments please send me your last 5 year medical history(if any) and your current predicted disease(if you opted for it). We\'be connecting shortly for further process. ',
        'chatId':newChat['_id']
      }));
      return resp.statusCode;
    }catch(err){
      print(err);
    }
  }
  Future getName() async{
    var prefs=await SharedPreferences.getInstance();
    setState(() {
      name=prefs.getString('name');
      token=prefs.getString('token');
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  late Razorpay _razorpay;
  String? timeSelected;
  void openCheckout() async {
    var options = {
      'key': 'rzp_test_2ytPPfpgQ4ygO1',
      'amount': 50000,
      'name': 'Test',
      'description': 'Test',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '6387202859', 'email': 'sudhanshu.mittal.49@gmail.com'},
      'external': {
        'wallets': ['phonepe']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)async {
    print('Success Response: ${response.paymentId}');
    print('oyeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    await createChat();
    await postFirstMessage();
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ChatScreen(chatId: newChat['_id'], pic: widget.image, name: widget.name)))
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message}');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: ${response.walletName}');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.center,child: CircularImage(source:widget.image,radius: 75, )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.center,child: AutoSizeText(widget.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText('Qualification:',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText(widget.qualification,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText('Specilization:',style: TextStyle(fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText(widget.specialization,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText('Current Location:',style: TextStyle(fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: AutoSizeText(widget.currentLocation,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ),
            SizedBox(height: size.height*0.025,),
            Align(alignment: Alignment.center,child: ElevatedButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText('Select your time slot'),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          timeSelected='7:30 PM-9:30 PM';
                        });
                        openCheckout();
                        Navigator.pop(context);

                      },child: Text('7:30 PM-9:30 PM'),),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          timeSelected='10:30 AM - 1:30 PM';
                        });
                        openCheckout();
                        Navigator.pop(context);
                      },child: Text('10:30 AM - 1:30 PM'),),
                    ],
                  ),
                );
              });
            },child: Text('Consult Now!'),),)
          ],
        ),
      ),
    );
  }
}
