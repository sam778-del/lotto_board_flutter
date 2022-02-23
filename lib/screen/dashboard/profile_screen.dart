import 'package:lotto_board/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:lotto_board/controllers/MenuController.dart';
import 'package:provider/provider.dart';
import 'package:pricing_cards/pricing_cards.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lotto_board/controllers/Animation.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget>  createState() => InitState();
}

class InitState extends State<ProfileScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: initWidget(),
            ),
          ],
        ),
      ),
    );
  }

  initWidget() {
    return Sizer(
     builder: (context, orientation, deviceType) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Plans",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _fbKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'first_name',
                            controller: _firstnameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xffF5591F),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Color(0xffF5591F),
                              ),
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    ),
                  ],
                ),
                child: new TextField(
                  controller: _lastnameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xffF5591F),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xffF5591F),
                    ),
                    hintText: "Last Name",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),

              Container(
                width: 80.h,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          FormBuilder(
                            key: _fbKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  name: 'email',
                                  controller: _emailController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color(0xffF5591F),
                                  decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color: Color(0xffF5591F),
                                  ),
                                    hintText: "Enter Email",
                                    hintStyle: TextStyle(color: Colors.black),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              GestureDetector(
                onTap: () => {
                  
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 60),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                    ),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: _loading == true ? Animations.loading() : Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
     }
    );
  }
}