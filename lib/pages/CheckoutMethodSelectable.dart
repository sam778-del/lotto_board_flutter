import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:lotto_board/services/initiliaze_paystack.dart';
import 'package:lotto_board/utils/hexToColor.dart';
import 'package:lotto_board/widgets/button.dart';
import '../controllers/submit_order.dart';
import '../screen/dashboard/subscription_screen.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:get/instance_manager.dart';

class CheckoutMethodSelectable extends StatefulWidget {
  const CheckoutMethodSelectable({Key? key, required this.id, required this.duration, required this.price, required this.user, required this.email}) : super(key: key);
  final String id;
  final String duration;
  final int price;
  final String user;
  final String email;
  @override
  _CheckoutMethodSelectableState createState() => _CheckoutMethodSelectableState();
}

// Pay public key
class _CheckoutMethodSelectableState extends State<CheckoutMethodSelectable> {
  final UserDataController userDataController = Get.put(UserDataController());
  bool isGeneratingCode = false;
  final plugin = PaystackPlugin();
  SubmitOrderService order = SubmitOrderService();
  @override
  void initState() {
    plugin.initialize(
        publicKey: "pk_test_4543774820e0c9f02418e831b721d54e4182a401");
    super.initState();
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: hexToColor("#41aa5e"),
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  chargeCard() async {
    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Map accessCode = await createAccessCode("sk_test_99046f1f28c1a28847e7862a0b986c8f3ca35f4a", widget.price * 100, widget.email);
    setState(() {
      isGeneratingCode = !isGeneratingCode;
    });

    Charge charge = Charge()
      ..amount = widget.price * 100
      ..accessCode = accessCode["data"]["access_code"]
      ..email = "${widget.email}";
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      handleOnSuccess(response);
    } else {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay With Paystack",
        ),
        backgroundColor: Color(0xFF363f93),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Button(
              child: Text(
                isGeneratingCode ? "Processing.." : "Make Payment",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onClick: () => chargeCard(),
            ),
          )),
    );
  }

  handleOnSuccess(transaction) async{
    setState(() {
      order.id = widget.id;
      order.user = widget.email;
      order.card_number = 'NONE';
      order.card_exp_month = 'NONE';
      order.card_exp_year = 'NONE';
      order.status = 'success';
    });
    await order.submitOrderData();
    userDataController.fetchDOData();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SubscriptionScreen(),
    ));
    _showDialog();
  }
}