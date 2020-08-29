import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/i_product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/user');
        break;
      default:
    }
  }

  void _onFetchProductsPressed() {
    Redux.store
        .dispatch(new ProductActions(page: 1, size: 20).getAllProductsAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(widget.title),
      ),
      //drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Fetch Products"),
            onPressed: _onFetchProductsPressed,
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.productsState.isLoading,
            builder: (context, isLoading) {
              if (isLoading) {
                return LinearProgressIndicator();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.productsState.isError,
            builder: (context, isError) {
              if (isError) {
                return Text("Failed to get products");
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          Expanded(
              child: StoreConnector<AppState, List<IProduct>>(
                  distinct: true,
                  converter: (store) => store.state.productsState.products,
                  builder: (context, products) {
                    // return ListView(
                    //   children: _buildProducts(products),
                    // );
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(3.0),
                        children: _buildProducts(products),
                      ),
                    );
                  }))
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop),
            title: Text('Product'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.purple[800],
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _buildProducts(List<IProduct> products) {
    if (products != null)
      return products
          .map((product) => Card(
              elevation: 1.0,
              margin: new EdgeInsets.all(8.0),
              child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Center(
                                child: Icon(
                              Icons.book,
                              size: 30.0,
                              color: Colors.black,
                            )),
                            SizedBox(height: 20.0),
                            new Center(
                              child: new Text(product.title,
                                  style: new TextStyle(
                                      fontSize: 18.0, color: Colors.white)),
                            ),
                            SizedBox(height: 20.0),
                            new Center(
                              child: new Text(
                                product.price.toString(),
                                style: new TextStyle(
                                    fontSize: 20, color: Colors.red),
                              ),
                            )
                          ])))))
          .toList();
    else
      return null;
  }
}
