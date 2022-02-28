import 'package:flutter/material.dart';
import 'package:lotto_board/widgets/button.dart';

class PaystackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay With Paystack"),
        backgroundColor: Color(0xFF363f93),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Center(child: Text("Paystack Payment methods")),
            SizedBox(height: 20,),
            Button(
              child: Text(
                "Paystack Check out method(Card)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onClick: () => Navigator.pushNamed(context, "/checkOutMethodCard")
            ),
            SizedBox(height: 20,),
            Button(
              child: Text(
                "Paystack Check out method(Selectable)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onClick: () => Navigator.pushNamed(context, "/checkOutMethodSelectedable")
            ),
            SizedBox(height: 20,),
            Button(
              child: Text(
                "Paystack Check out method(Bank)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onClick: () => Navigator.pushNamed(context, "/checkOutMethodBank")
            ),
            SizedBox(height: 20,),
            Button(
              child: Text(
                "Paystack Check out method(UI)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onClick: () => Navigator.pushNamed(context, "/checkOutMethodUI")
            ),
            
          ],
        ),
      )),
    );
  }
}