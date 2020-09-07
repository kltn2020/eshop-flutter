import 'package:flutter/material.dart';

class AddressCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Shipping Address",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    'name': "Name 1",
                    'number': "Number 1",
                    'address': "Address 1",
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Number"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Address detail"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    'name': "Name 2",
                    'number': "Number 2",
                    'address': "Address 2",
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Number"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Address detail"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    'name': "Name 3",
                    'number': "Number 3",
                    'address': "Address 3",
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Number"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Address detail"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
