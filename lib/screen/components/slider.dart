import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllSlider extends StatefulWidget {
  const AllSlider({Key? key}) : super(key: key);
  @override
  _AllSliderState createState() => _AllSliderState();
}

class _AllSliderState extends State<AllSlider> {
  var articles = "";
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          color:Colors.white,
          child: SafeArea(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.02,),
                  Container(
                    padding: const EdgeInsets.only(left:20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon:
                            Icon(Icons.arrow_back_ios, color:Color(0xFF363f93)),
                            onPressed:()=> Navigator.pop(context)),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon:
                            Icon(Icons.home_outlined, color:Color(0xFF363f93)),
                            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Container()))),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //debugPrint(article.img.toString());
                           GestureDetector(
                              onTap:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>Container())
                                );
                              },
                              child:Container(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  height: 250,

                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:35,
                                          child: new Material (
                                              elevation: 0.0,
                                              child: new Container(
                                                height: 180.0,
                                                width: width*0.9,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(0.0),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        offset: new Offset(0.0, 0.0),
                                                        blurRadius: 20.0,
                                                        spreadRadius: 4.0)],
                                                ),
                                                // child: Text("This is where your content goes")
                                              )
                                          )
                                      ),
                                    ],
                                  )
                              )
                          )
                        ]
                      ),

                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}