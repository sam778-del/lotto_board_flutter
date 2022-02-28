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

class SubscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget>  createState() => InitState();
}

class InitState extends State<SubscriptionScreen> {
  final PricingController pricingData = Get.put(PricingController());

  late Timer timer;

  @override
  void initState() {
    pricingData.fetchPricing();
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
        else
        return Sizer(
          builder: (context, orientation, deviceType) {
            return SafeArea(
              child: new Center(
                child: new RefreshIndicator(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 100.h,
                        child: Column(
                          children: getList(),
                        ),
                      ),
                    )
                  ),
                  onRefresh: _refreshAds
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
                PricingCards(
                  pricingCards: [
                    PricingCard(
                      title: '${e["name"]}',
                      price: '\₦ ${e["price"]}',
                      subPriceText: '\/${e["duration"].substring(0,3)}',
                      billedText: 'Billed ${e["duration"]}',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GatewayScreen(id: "${e["id"]}", duration: "${e["duration"]}", price: e["price"]),
                        ));
                      },
                    ),
                  ],
                ),
            ]))
        .toList();
    return childs;
  }

  Future<Null> _refreshAds() async{
   pricingData.fetchPricing();
  }
}