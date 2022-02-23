import 'package:lotto_board/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import '../components/navigation_drawer_widget.dart';
import 'package:lotto_board/controllers/MenuController.dart';
import 'package:provider/provider.dart';
import 'package:pricing_cards/pricing_cards.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget>  createState() => InitState();
}

class InitState extends State<SubscriptionScreen> {

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Container(
                            width: 80.h,
                            child: Column(
                              children: [
                                PricingCards(
                                  pricingCards: [
                                    PricingCard(
                                      title: 'Monthly',
                                      price: '\$ 9.99',
                                      subPriceText: '\/mo',
                                      billedText: 'Billed monthly',
                                      onPress: () {
                                        // make your business
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                PricingCards(
                                  pricingCards: [
                                    PricingCard(
                                      title: 'Monthly',
                                      price: '\$ 59.99',
                                      subPriceText: '\/mo',
                                      billedText: 'Billed anually',
                                      mainPricing: true,
                                      mainPricingHighlightText: 'Save money',
                                      onPress: () {
                                        // make your business
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: 30),
                                PricingCards(
                                  pricingCards: [
                                    PricingCard(
                                      title: 'Monthly',
                                      price: '\$ 9.99',
                                      subPriceText: '\/mo',
                                      billedText: 'Billed monthly',
                                      onPress: () {
                                        // make your business
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]
                      )
                    )
                  )
                ],
              )
            ],
          ),
        ),
      );
     }
    );
  }
}