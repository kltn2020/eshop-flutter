import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  CheckOut({Key key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final List<String> items = ['apple', 'banana', 'orange', 'lemon'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Check Out",
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
              Container(
                child: Column(
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/address-checkout");
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Name/Number"),
                                Text("Address detail"),
                              ],
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    ...items
                        .map(
                          (item) => ProductInCheckOut(
                            title: item,
                          ),
                        )
                        .toList(),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Payment Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/payment-checkout");
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Payment Type: "),
                            Row(
                              children: [
                                Text("Cash"),
                                Icon(Icons.navigate_next),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cart total: 10000"),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Shipping total: 10000"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Order total: 20000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            onPressed: null,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(146, 127, 191, 1),
                                      Color.fromRGBO(79, 59, 120, 1)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft),
                              ),
                              child: Center(
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductInCheckOut extends StatelessWidget {
  final String title;

  final int number;

  ProductInCheckOut({
    Key key,
    this.title,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Image(
              //   image: AssetImage('assets/banner1.jpg'),
              //   height: 128,
              //   width: 128,
              // ),
              Icon(
                Icons.laptop,
                size: 64,
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Text("$title"),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "x 1",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            "Total: 1000000",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
