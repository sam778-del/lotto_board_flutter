import 'package:lotto_board/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import '../components/navigation_drawer_widget.dart';
import 'package:lotto_board/controllers/MenuController.dart';
import 'package:provider/provider.dart';
import 'package:pricing_cards/pricing_cards.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:lotto_board/screen/components/pricing.dart';
import 'dart:async';
import 'package:lotto_board/screen/dashboard/gateway.dart';
import 'package:lotto_board/screen/components/shimmer_ghana.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:lotto_board/screen/components/plan_active.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget>  createState() => InitState();
}

class InitState extends State<SubscriptionScreen> {
  final PricingController pricingData = Get.put(PricingController());
  final PlanActiveController planActive = Get.put(PlanActiveController());

  late Timer timer;

  @override
  void initState() {
    pricingData.fetchPricing();
    planActive.fetchPricing();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigationDrawerWiget(),
      appBar: AppBar(
        title: Text("Plans"),
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
    return SingleChildScrollView(
      child: Obx(() {
        if(pricingData.isLoading == true)
          return CarouselLoading();
        // ignore: unrelated_type_equality_checks
        else if(UserDataController.UserPlan != '1' && planActive.isLoading == false)
          return Sizer(
            builder: (context, orientation, deviceType) {
              return SafeArea(
                child: new Center(
                  child: new RefreshIndicator(
                  onRefresh: _refreshAds,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.h,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Active Plan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: 100.h,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 300,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.green,
                                    elevation: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 85),
                                        Center(
                                          child: ListTile(
                                            title: Text(
                                              '${planActive.PlanName}', 
                                              style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text('${planActive.PlanExpiryDate}', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                                          ), 
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  )
                )
              );
            }
          );
        else
        return Sizer(
          builder: (context, orientation, deviceType) {
            return SafeArea(
              child: new Center(
                child: new RefreshIndicator(
                  onRefresh: _refreshAds,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.h,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Choose\nYour Plan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 100.h,
                                child: Column(
                                  children: getList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                )
              )
            );
          }
        );
      }),
    );
  }

  List<Widget> getList() {
    List<Widget> childs = pricingData.PricingData
        .map((e) => Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
          children: <Widget>[
                SizedBox(height: 30),
                PricingCards(
                  pricingCards: [
                    PricingCard(
                      title: '${e["name"]}',
                      price: '\₦ ${e["price"]}',
                      subPriceText: '\/${e["duration"].substring(0,3)}',
                      billedText: 'Billed ${e["duration"]}',
                      mainPricing: e["duration"] == "Yearly" ? true : false,
                      mainPricingHighlightText: 'Save money',
                      cardColor: e["duration"] == "Yearly" ? Colors.green : Colors.pink,
                      priceStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      ),
                      titleStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                      ),
                      billedTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                      ),
                      subPriceStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                      ),
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GatewayScreen(id: "${e["id"]}", duration: "${e["duration"]}", price: e["price"]),
                        ));
                      },
                      cardBorder: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 4.0),
                          borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
            ]))
        .toList();
    return childs;
  }

  Future<Null> _refreshAds() async{
   pricingData.fetchPricing();
   planActive.fetchPricing();
  }
}