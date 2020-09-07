import 'package:flutter/material.dart';

class VoucherApply extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Apply Voucher",
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
            FlatButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.redAccent,
                child: Center(
                  child: Text(
                    "Remove Voucher",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 'Voucher 1');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Voucher 1",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount: %"),
                        Text("Category: Laptop"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "start date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          " - ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "end date",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              // indent: 20,
              // endIndent: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 'Voucher 2');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Voucher 2",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount: %"),
                        Text("Category: Laptop"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "start date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          " - ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "end date",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              // indent: 20,
              // endIndent: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 'Voucher 3');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Voucher 3",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount: %"),
                        Text("Category: Laptop"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "start date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          " - ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "end date",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              // indent: 20,
              // endIndent: 0,
            ),
          ],
        ),
      ),
    );
  }
}
