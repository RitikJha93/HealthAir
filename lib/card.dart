import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key,required this.name,this.specialization,required this.qualification,required this.image}) : super(key: key);
  final name,specialization,qualification,image;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: SizedBox(
        width: 175,
        height: 200,
        child: Material(
          borderRadius: BorderRadius.circular(10),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularImage(
                      radius: 50,
                      source:
                          widget.image,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(widget.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AutoSizeText(widget.qualification,style: TextStyle(fontSize: 10),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AutoSizeText(widget.specialization),
                ),

              ],
            )),
      ),
    );
  }
}
