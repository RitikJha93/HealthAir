import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:progresso/progresso.dart';

class DetectedDisease extends StatefulWidget {
  const DetectedDisease({Key? key, required this.data,required this.l1,required this.l2}) : super(key: key);
  final data;
  final l1;
  final l2;

  @override
  State<DetectedDisease> createState() => _DetectedDiseaseState();
}

class _DetectedDiseaseState extends State<DetectedDisease> {

  @override
  Widget build(BuildContext context) {
    // var dat=Map<String, dynamic>.from(widget.data);


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AutoSizeText('You Might have one of the following illness',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(Icons.info),
                      message:
                      'We do not take any authority of the following predictions, please make sure that you consult the doctor in the next window to be sure of the situation. We wish you good health.',
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*0.84,
                child: ListView.builder(itemCount: widget.l1.length,itemBuilder: (BuildContext context,int index){
                  // print(widget.data);
                  // print(object)
                  return Card(
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(widget.l2[index],style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                            // AutoSizeText(widget.l1[index].toString()),
                            Progresso(progress: double.parse(widget.l1[index].toString())/100,),
                            SizedBox(height: 20,),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText('Probability Score:',),
                                  AutoSizeText(widget.l1[index].toString().substring(0,5)),
                                  AutoSizeText('%')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
