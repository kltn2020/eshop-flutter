import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/components/drawer_menu.dart';

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
  void _onFetchProductsPressed() {
    Redux.store.dispatch(fetchProductsAction);
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
      drawer: DrawerMenu(),
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
                return ListView(
                  children: _buildProducts(products),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProducts(List<IProduct> products) {
    return products
        .map(
          (product) => ListTile(
            title: Text(
              product.title,
            ),
            subtitle: Text(product.price.toString()),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
            key: Key(product.id.toString()),
          ),
        )
        .toList();
  }
}
