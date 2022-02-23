import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lotto_board/screen/components/navigation_drawer_widget.dart';
import 'package:lotto_board/screen/components/dashboard_controller.dart';
import 'package:lotto_board/screen/components/shimmer_ghana.dart';
import 'package:lotto_board/screen/components/carousel_slider_data_found.dart';
import 'package:get/get.dart';
import 'package:lotto_board/screen/components/dashboard_controller.dart';
import 'package:lotto_board/screen/components/about_us.dart';
import 'package:lotto_board/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'dart:async';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  DashbaordScreen createState() => DashbaordScreen();
}

class DashbaordScreen extends State<DashboardScreen> {
  final DashboardController dashBoardData = Get.put(DashboardController());
  List imageList = [];

  late Timer timer;

  @override
  void initState() {
    dashBoardData.fetchDashboardCarousel();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  addValue() async{
    setState(() {
      imageList = [];
      imageList = dashBoardData.CarouselData;
    });
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+2349069307291',
      text: "Hey! I'm inquiring about Lotto Board",
    );
    await launch('$link');
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigationDrawerWiget(),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color(0xFF363f93),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Obx(() {
                if(dashBoardData.isLoading == true)
                  return CarouselLoading();
                else 
                  return initWidget();
              }),
              //child: initWidget(),
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
          child: new Center(
            child: new RefreshIndicator(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              child: CarouselSlider.builder(
                                itemCount: imageList.length,
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: 60.h,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 5),
                                  reverse: false,
                                  aspectRatio: 5.0,
                                ),
                                itemBuilder: (context, i, id){
                                  //for onTap to redirect to another screen
                                  return GestureDetector(
                                    child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0xFF363f93),)
                                    ),
                                      //ClipRRect for image border radius
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          imageList[i],
                                        width: 800,
                                        fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      var url = imageList[i];
                                      print(url.toString());
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                          ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Container(
                      width: 100.h,
                      height: 50.h,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 20.h,
                                  width: 50.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                        title: Center(
                                          child: Text(
                                            "About Us",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.height * 0.0125,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          AboutUs();
                                        }
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.green,
                                      color: Colors.white,
                                      margin: EdgeInsets.all(20),
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 20.h,
                                  width: 50.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                          title: Center(
                                          child: Text(
                                            "Need Help?",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.height * 0.0125,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          launchWhatsApp();
                                        },
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.green,
                                      color: Colors.white,
                                      margin: EdgeInsets.all(20),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onRefresh: _refreshAds
            )
          ),
        );
      },
    );
  }

  Future<Null> _refreshAds() async{
   dashBoardData.fetchDashboardCarousel();
   addValue();
  }

  void AboutUs() {
    showDialog(
      context: context,
      builder: (context) {
        return PolicyDialog(
          mdFileName: 'about_us.md',
        );
      },
    ); 
  }
}