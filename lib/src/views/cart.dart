import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool selectAllCheck = false;
  bool productCheck = false;
  int productCount = 0;

  final List<String> items = ['apple', 'banana', 'orange', 'lemon'];

  var applyVoucher;

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/voucher-apply');

    setState(() {
      applyVoucher = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Cart",
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
              Row(
                children: [
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: selectAllCheck,
                    onChanged: (bool value) {
                      setState(() {
                        selectAllCheck = value;
                      });
                    },
                  ),
                  Text("Check all"),
                ],
              ),
              ...items
                  .map(
                    (item) => ProductInCart(
                      title: item,
                      check: selectAllCheck,
                      onChecked: (bool value) {
                        setState(
                          () {
                            selectAllCheck = value;
                          },
                        );
                      },
                      number: productCount,
                      onAdd: () {
                        setState(
                          () {
                            productCount++;
                          },
                        );
                      },
                      onSubtract: () {
                        setState(
                          () {
                            productCount--;
                          },
                        );
                      },
                      onDelete: () {
                        setState(
                          () {
                            productCount = 0;
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: 10000000",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              new GestureDetector(
                onTap: () {
                  _navigateAndDisplaySelection(context);
                },
                child: Text(
                  applyVoucher == null ? "Apply Voucher >" : applyVoucher,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/checkout"),
        tooltip: 'Click to checkout',
        child: Text("Buy"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProductInCart extends StatelessWidget {
  final String title;
  final bool check;
  final Function onChecked;
  final int number;
  final Function onAdd;
  final Function onSubtract;
  final Function onDelete;

  ProductInCart({
    Key key,
    this.title,
    this.check,
    this.onChecked,
    this.number,
    this.onAdd,
    this.onSubtract,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: check,
                onChanged: onChecked,
              ),
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
                      Text("1000000"),
                    ],
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: onDelete)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: onSubtract),
              SizedBox(
                width: 30,
              ),
              Text("$number"),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.add_circle_outline), onPressed: onAdd),
            ],
          )
        ],
      ),
    );
  }
}
