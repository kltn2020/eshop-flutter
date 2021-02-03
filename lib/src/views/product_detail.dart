import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/Rating.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_state.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';
import 'package:ecommerce_flutter/src/redux/ratings/ratings_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/views/rating_create.dart';
import 'package:ecommerce_flutter/src/views/rating_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage({@required this.product});

  final formatter = new NumberFormat("#,###");
  final dateF = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: StoreConnector<AppState, Cart>(
              distinct: true,
              converter: (store) => store.state.cartState.cart,
              builder: (context, cart) {
                return Stack(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 32,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cart.products
                              .fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.quantity)
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: Container(
        child: StoreConnector<AppState, ProductsState>(
            distinct: true,
            converter: (store) => store.state.productsState,
            onInit: (store) {
              Redux.store.dispatch(ProductActions()
                  .getProductDetailAction(Redux.store, product.id));
              Redux.store.dispatch(ProductActions()
                  .getContentBaseRecommendAction(Redux.store, 1, 20));
              Redux.store.dispatch(ProductActions()
                  .getCollaborativeRecommendAction(Redux.store, 1, 10));
            },
            builder: (context, productState) {
              if (productState.productDetail != null && !productState.isLoading)
                return productInfo(
                    context,
                    productState.productDetail,
                    productState.recommendContentProducts,
                    productState.recommendCollabProducts);
              else
                return productInfo(context, product, [], []);
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Redux.store
              .dispatch(CartActions().addCartAction(Redux.store, product, 1));
        },
        icon: Icon(
          Icons.add_shopping_cart,
        ),
        label: Text("Add to cart"),
        backgroundColor: Color.fromRGBO(79, 59, 120, 1),
      ),
    );
  }
}

Widget productInfo(
    BuildContext context,
    Product productData,
    List<Product> recommendContentProductList,
    List<Product> recommendCollabProductList) {
  final formatter = new NumberFormat("#,###");
  final dateF = new DateFormat('dd/MM/yyyy');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: productData.id,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.network(productData.images[0]['url']),
          ),
        ),
        //Name
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            productData.name,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        //Price
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: AutoSizeText(
                  formatter.format(productData.discountPrice) + ' VND',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(146, 127, 191, 1),
                  ),
                  maxLines: 1,
                ),
              ),
              productData.price != productData.discountPrice
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: AutoSizeText(
                          formatter.format(productData.price),
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 24,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        //Review count - Sold - Favorite
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Review count: " + formatter.format(productData.ratingCount)),
              Text("Sold: " + formatter.format(productData.sold)),
              Container(
                child: StoreConnector<AppState, FavoriteState>(
                  distinct: true,
                  converter: (store) => store.state.favoriteState,
                  builder: (context, favoriteState) {
                    return favoriteState.favoriteList.product
                                .where(
                                    (iproduct) => iproduct.id == productData.id)
                                .toList()
                                .length >
                            0
                        ? FlatButton(
                            onPressed: () {
                              Redux.store.dispatch(
                                FavoriteActions(
                                        token:
                                            Redux.store.state.userState.token,
                                        product: productData)
                                    .deleteFavoriteAction,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Color.fromRGBO(196, 187, 240, 1),
                              ),
                            ),
                          )
                        : FlatButton(
                            onPressed: () {
                              Redux.store.dispatch(
                                FavoriteActions(
                                        token:
                                            Redux.store.state.userState.token,
                                        product: productData)
                                    .addFavoriteAction,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
        //Product Detail
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Detail",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(79, 59, 120, 0.8),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "General",
                          style: TextStyle(
                            // color: Color.fromRGBO(146, 127, 191, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SKU: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.sku != null
                            ? Expanded(
                                child: Text(productData.sku,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.categoryId != null
                            ? Expanded(
                                child: Text(productData.categoryId.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Brand: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.brandId != null
                            ? Expanded(
                                child: Text(productData.brandId.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Configuration",
                          style: TextStyle(
                            // color: Color.fromRGBO(196, 187, 240, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CPU: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.cpu != null
                            ? Expanded(
                                child: Text(productData.cpu,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GPU: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.gpu != null
                            ? Expanded(
                                child: Text(productData.gpu,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OS: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.os != null
                            ? Expanded(
                                child: Text(productData.os,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RAM: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.ram != null
                            ? Expanded(
                                child: Text(productData.ram,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Storage: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.storage != null
                            ? Expanded(
                                child: Text(productData.storage,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Features: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.newFeature != null
                            ? Expanded(
                                child: Text(productData.newFeature,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Display",
                          style: TextStyle(
                            // color: Color.fromRGBO(196, 187, 240, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Display: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.display != null
                            ? Expanded(
                                child: Text(productData.display,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Display Resolution: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.displayResolution != null
                            ? Text(productData.displayResolution)
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Display Screen: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.displayScreen != null
                            ? Expanded(
                                child: Text(productData.displayScreen,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Camera",
                          style: TextStyle(
                            // color: Color.fromRGBO(196, 187, 240, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Camera: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.camera != null
                            ? Expanded(
                                child: Text(productData.camera,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Video: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.video != null
                            ? Expanded(
                                child: Text(productData.video,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Connectivity",
                          style: TextStyle(
                            // color: Color.fromRGBO(196, 187, 240, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wifi: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.wifi != null
                            ? Expanded(
                                child: Text(productData.wifi,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bluetooth: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.bluetooth != null
                            ? Expanded(
                                child: Text(productData.bluetooth,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ports: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.ports != null
                            ? Expanded(
                                child: Text(productData.ports,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Physical Details",
                          style: TextStyle(
                            // color: Color.fromRGBO(196, 187, 240, 1),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Size: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.size != null
                            ? Expanded(
                                child: Text(productData.size,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weight: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.weight != null
                            ? Expanded(
                                child: Text(productData.weight,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Material: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.material != null
                            ? Expanded(
                                child: Text(productData.material,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Battery Capacity: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        productData.batteryCapacity != null
                            ? Expanded(
                                child: Text(productData.batteryCapacity,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            : Text(""),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                productData.description != null ? productData.description : "",
                style: TextStyle(),
              ),
            ],
          ),
        ),
        //Review
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(79, 59, 120, 0.8),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RatingList(
                              productId: productData.id,
                            ),
                          ));
                    },
                    child: Container(
                      child: Text("See more >"),
                    ),
                  ),
                ],
              ),

              //Review
              Container(
                child: StoreConnector<AppState, List<Rating>>(
                  distinct: true,
                  onInit: (store) => store.dispatch(RatingActions()
                      .getAllRatingAction(store, productData.id, 1, 10)),
                  rebuildOnChange: true,
                  converter: (store) => store.state.ratingState.ratingList,
                  builder: (context, ratingList) {
                    return Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ratingList != null
                              ? ratingList.sublist(0, 5).map((item) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                color: Color.fromRGBO(
                                                    146, 127, 191, 1),
                                              ),
                                              child: Center(
                                                child: AutoSizeText(
                                                  item.userEmail[0]
                                                      .toUpperCase(),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      child: AutoSizeText(
                                                        item.userEmail,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: item.point != null
                                                          ? item.point
                                                              .toDouble()
                                                          : 0.0,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      child: Text(
                                                          item.content != null
                                                              ? item.content
                                                              : ''),
                                                    ),
                                                    Text(
                                                      item.updatedAt != null
                                                          ? dateF.format(
                                                              DateTime.parse(item
                                                                  .updatedAt))
                                                          : '',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList()
                              : [],
                        ),
                      ),
                    );
                  },
                ),
              ),

              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewCreate(
                          productId: productData.id,
                        ),
                      ));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Create new Review",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              //End Reviews
            ],
          ),
        ),

        //Recommend product list
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Similar Products",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(79, 59, 120, 0.8),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 250,
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: recommendContentProductList.map((product) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  product: product,
                                ),
                              ));
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                          product.images[0]['url']),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  product.name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              product.discountPrice != null
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              formatter.format(
                                                      product.discountPrice) +
                                                  ' VND',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromRGBO(
                                                    146, 127, 191, 1),
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          product.price != product.discountPrice
                                              ? AutoSizeText(
                                                  formatter
                                                      .format(product.price),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  : AutoSizeText(
                                      (product.price != null
                                          ? formatter.format(product.price)
                                          : "Contact"),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(146, 127, 191, 1),
                                      ),
                                      maxLines: 1,
                                    )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You may also like",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(79, 59, 120, 0.8),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 250,
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: recommendCollabProductList.map((product) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  product: product,
                                ),
                              ));
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                          product.images[0]['url']),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  product.name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              product.discountPrice != null
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              formatter.format(
                                                      product.discountPrice) +
                                                  ' VND',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromRGBO(
                                                    146, 127, 191, 1),
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          product.price != product.discountPrice
                                              ? AutoSizeText(
                                                  formatter
                                                      .format(product.price),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  : AutoSizeText(
                                      (product.price != null
                                          ? formatter.format(product.price) +
                                              ' VND'
                                          : "Contact"),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(146, 127, 191, 1),
                                      ),
                                      maxLines: 1,
                                    )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
