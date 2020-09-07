import 'package:flutter/material.dart';

class PaymentCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Payment Type",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text("Cash"),
              onTap: () => {
                Navigator.pop(context, 'Cash'),
              },
            ),
            ListTile(
              title: Text("Bank Transfer"),
              onTap: () => {
                Navigator.pop(context, 'Bank Transfer'),
              },
            ),
          ],
        ),
      ),
    );
  }
}
