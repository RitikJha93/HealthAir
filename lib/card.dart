import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: SizedBox(
        width: 125,
        height: 75,
        child: Material(
            elevation: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Image.network(
                      'https://www.healthvision.co.in/images/male.png'),
                ),
                AutoSizeText('Name...',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                AutoSizeText('Qualification',style: TextStyle(fontSize: 10),),
                AutoSizeText('Specialization'),

              ],
            )),
      ),
    );
  }
}
