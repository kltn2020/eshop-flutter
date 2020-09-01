import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../animations/fade_animation.dart';
import '../widgets/CategoryItem.dart';

class HomePage extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool typing = false;

  List bannerAdSlider = [
    "assets/banner1.jpg",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
    "assets/banner4.jpg",
    "assets/banner5.jpg",
    "assets/banner6.jpg",
    "assets/banner7.jpg",
    "assets/banner8.jpg"
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, '/product-list');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: typing
            ? TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                ),
              )
            : Text(
                "Eshop",
                style: TextStyle(
                  color: Color.fromRGBO(79, 59, 120, 1),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                ),
              ),
        leading: IconButton(
          icon: Icon(typing ? Icons.done : Icons.search),
          color: Color.fromRGBO(146, 127, 191, 1),
          onPressed: () {
            setState(() {
              typing = !typing;
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: Container(
          child: StoreConnector<AppState, String>(
        distinct: true,
        converter: (store) => store.state.userState.token,
        builder: (context, token) {
          if (token == null) {
            return Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                        "No authority! Please click button below to login"),
                  ),
                  Center(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Back to Login",
                          style: TextStyle(color: Colors.grey),
                        )),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // banner ad slider

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                        ),
                        items: bannerAdSlider.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    // banner ad slider

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(54, 59, 78, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          CategoryItem(
                              icon: Icons.smartphone,
                              size: 70,
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                              name: "Phone"),
                          CategoryItem(
                            icon: Icons.computer,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Laptop",
                          ),
                          CategoryItem(
                            icon: Icons.headset,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Headphone",
                          ),
                          CategoryItem(
                              icon: Icons.smartphone,
                              size: 70,
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                              name: "Phone"),
                          CategoryItem(
                            icon: Icons.computer,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Laptop",
                          ),
                          CategoryItem(
                            icon: Icons.headset,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Headphone",
                          ),
                          CategoryItem(
                              icon: Icons.smartphone,
                              size: 70,
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                              name: "Phone"),
                          CategoryItem(
                            icon: Icons.computer,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Laptop",
                          ),
                          CategoryItem(
                            icon: Icons.headset,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Headphone",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(54, 59, 78, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // GridView.count(
                    //   physics: ClampingScrollPhysics(),
                    //   crossAxisCount: 2,
                    //   shrinkWrap: true,
                    //   childAspectRatio: 1 / 1.25,
                    //   children: products.map((product) {
                    //     return Stack(
                    //       children: <Widget>[
                    //         Container(
                    //           child: Column(
                    //             children: <Widget>[
                    //               Hero(
                    //                 tag: product.image,
                    //                 child: AspectRatio(
                    //                   aspectRatio: 1 / 1,
                    //                   child: Image(
                    //                     image: AssetImage(product.image),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Text(
                    //                 product.productName,
                    //               ),
                    //               Text(
                    //                 "${product.price}\$",
                    //                 style: TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.amber,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         Material(
                    //           color: Colors.transparent,
                    //           child: InkWell(
                    //             onTap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) => ProductPage(
                    //                       product: product,
                    //                     ),
                    //                   ));
                    //             },
                    //           ),
                    //         )
                    //       ],
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
            );
          }
        },
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.laptop),
      //       title: Text('Product'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       title: Text('Notification'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text(
      //         'User',
      //       ),
      //     ),
      //   ],
      //   currentIndex: 0,
      //   unselectedItemColor: Colors.black,
      //   selectedItemColor: Colors.purple[800],
      //   onTap: _onItemTapped,
      // ),
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
        currentIndex: 0,
        selectedItemColor: Colors.purple[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
