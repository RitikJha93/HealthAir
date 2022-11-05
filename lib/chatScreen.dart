import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key, required this.chatId, required this.pic, required this.name})
      : super(key: key);
  final String chatId;
  final String pic;
  final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? token;
  var response;
  String? id;
  List resp = [];
  var messages;
  createInput() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Material(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5),
          //     margin: const EdgeInsets.symmetric(horizontal: 1.0),
          //     // child: IconButton(
          //     //   key: gifBtnKey,
          //     //   icon: Icon(Icons.attach_file),
          //     //   color: kPrimaryColor,
          //     //   onPressed: onAttachmentClick,
          //     // ),
          //     child: PopupMenuButton(
          //       icon: const Icon(
          //         Icons.attach_file,
          //       ),
          //       itemBuilder: (context) {
          //         return menu;
          //       },
          //     ),
          //   ),
          //   color: Colors.white,
          // ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                // controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Type message...",
                    hintStyle: TextStyle(color: Colors.grey)),
                // focusNode: focusNode,
              ),
            ),
          ),

          //SEND MESSAGE BUTTON
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                // color: kPrimaryColor,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getToken() async {
    final fss = await SharedPreferences.getInstance();
    String? tkn = await fss.getString('token');
    String? docId=await fss.getString('id');
    setState(() {
      token = tkn;
      id=docId;
    });
  }

  Future fetchChat() async {
    // setState(() {
    //   messages = [];
    // });
    getToken().whenComplete(() async {
      try {
        Map<String, String> header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
        final url = 'http:// 192.168.164.1:5000/api/message/${widget.chatId}';
        response = await http.get(
          Uri.parse(url),
          headers: header,
        );
        final jsonData = jsonDecode(response.body) as List;
        print(response.statusCode);
        setState(() {
          messages=jsonData;
        });
        // print(jsonData);
        // jsonData.forEach((element) {
        //   Map obj = element;
        //   print(element);
        //   Map user = obj['chat'];
        //   // Map users=user['users'];
        //
        //   Map sender = obj['sender'];
        //   print(user['users'][1]);
        //   print(sender['_id']);
        //   String msg = obj['content'];
        //   print(msg);
        //   if (user['users'][1] == sender['_id']) {
        //     print(true);
        //     setState(() {
        //       messages.add([msg, true]);
        //     });
        //   } else {
        //     setState(() {
        //       messages.add([msg, false]);
        //     });
        //   }
        // });
        print(messages);
      } catch (err) {
        print(err);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChat();
  }

  @override
  Widget build(BuildContext context) {
    // fetchChat();
    var size = MediaQuery.of(context).size;
    return Material(

      child: Scaffold(
        appBar: AppBar(title: Row(children: [
          CircleAvatar(child: Image.network(widget.pic),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.name),
          ),
          SizedBox(width: size.width*0.13,),
          IconButton(onPressed: (){}, icon: Icon(Icons.video_call))
          ,IconButton(onPressed: (){}, icon: Icon(Icons.call))
        ],),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          // alignment: AlignmentDirectional.bottomS,
          children: [
            ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: messages[index]['sender']['_id']==id
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 35.0,
                            maxHeight: 60.0,
                            minWidth: 60,
                            maxWidth: size.width*0.8
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: messages[index]['sender']['_id']==id
                                  ? Colors.red
                                  :Colors.amber
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(messages[index]['content']),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            createInput()
          ],
        ),
      ),
    );
    // color: Colors.white,
  }
}
