import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
// import '../widgets/drawer_menu.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<String> _listItem = [
    'assets/images/beauty.jpg',
    'assets/images/clothes.jpg',
    'assets/images/glass.jpg',
    'assets/images/perfume.jpg',
    'assets/images/tech.jpg',
    'assets/images/tech-1.jpg',
    'assets/images/tech.jpg',
    'assets/images/tech-1.jpg',
  ];

  final List<FadeAnimation> _appBarActions = [
    FadeAnimation(
        1.2,
        IconButton(
            icon: Icon(Icons.favorite, color: Colors.white), onPressed: () {})),
    FadeAnimation(
        1.3,
        IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {})),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      //drawer: DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: _appBarActions,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(20.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _listItem
                    .map((item) => Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover)),
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ))),
    );
  }
}
