import 'package:flutter/material.dart';
import 'package:lotto_board/controllers/MenuController.dart';
import '../components/navigation_drawer_widget.dart';
import 'package:lotto_board/constant.dart';
import 'package:sizer/sizer.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:lotto_board/pages/CheckoutMethodSelectable.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:get/instance_manager.dart';

class GatewayScreen extends StatefulWidget {
  const GatewayScreen({Key? key, required this.id, required this.duration, required this.price}) : super(key: key);
  final String id;
  final String duration;
  final int price;
  @override
  State<StatefulWidget>  createState() => InitState();
}

class InitState extends State<GatewayScreen>{
   final UserDataController userDataController = Get.put(UserDataController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        backgroundColor: Color(0xFF363f93),
      ),
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

  Widget initWidget() {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: new Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  height: 25.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(5.00)),
                        Container(
                          width: 40.w,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                            child: OutlinedButton(
                              child: Image.asset(
                                'assets/paystack-opengraph.png',
                                fit: BoxFit.fill,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CheckoutMethodSelectable(id: "${widget.id}", duration: "${widget.duration}", price: widget.price, user: "${userDataController.UserEmail}", email: "${userDataController.UserEmail}",),
                                ));
                              },
                            )
                          )
                        ),
                        Padding(padding: EdgeInsets.all(10.00)),
                        Container(
                          width: 40.w,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                            child: OutlinedButton(
                              child: Image.asset(
                                'assets/Recharge-Card-Printing.gif',
                                fit: BoxFit.fill,
                              ),
                              onPressed: () {

                              },
                            )
                          )
                        ),
                      ]),
                ),
              ),
          ),
        );
      },
    );
  }

  void _checkPayment() {
  }
}