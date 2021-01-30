import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/widgets/VerticalTabs.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/src/views/search_product.dart';

class BrandList {
  final String title;
  final Image icon;
  final int id;

  BrandList({this.title, this.icon, this.id});
}

class CategoryList extends StatelessWidget {
  final productBrandList = [
    BrandList(
      title: "Apple",
      icon: Image(
        image: AssetImage('assets/brands/apple32.png'),
      ),
      id: 1,
    ),
    BrandList(
      title: "DELL",
      icon: Image(
        image: AssetImage('assets/brands/dell32.png'),
      ),
      id: 2,
    ),
    BrandList(
      title: "Asus",
      icon: Image(
        image: AssetImage('assets/brands/asus32.png'),
      ),
      id: 4,
    ),
    BrandList(
      title: "Acer",
      icon: Image(
        image: AssetImage('assets/brands/acer32.png'),
      ),
      id: 6,
    ),
    BrandList(
      title: "LG",
      icon: Image(
        image: AssetImage('assets/brands/lg32.png'),
      ),
      id: 8,
    ),
    BrandList(
      title: "HP",
      icon: Image(
        image: AssetImage('assets/brands/hp32.png'),
      ),
      id: 3,
    ),
    BrandList(
      title: "Huawei",
      icon: Image(
        image: AssetImage('assets/brands/huawei32.png'),
      ),
      id: 9,
    ),
  ];

  final mouseBrandList = [
    BrandList(
      title: "Apple",
      icon: Image(
        image: AssetImage('assets/brands/apple32.png'),
      ),
    ),
    BrandList(
      title: "Microsoft",
      icon: Image(
        image: AssetImage('assets/brands/microsoft32.png'),
      ),
    ),
    BrandList(
      title: "Asus",
      icon: Image(
        image: AssetImage('assets/brands/asus32.png'),
      ),
    ),
    BrandList(
      title: "Logitech",
      icon: Image(
        image: AssetImage('assets/brands/logitech32.png'),
      ),
    ),
  ];

  final keyboardBrandList = [
    BrandList(
      title: "Apple",
      icon: Image(
        image: AssetImage('assets/brands/apple32.png'),
      ),
    ),
    BrandList(
      title: "Microsoft",
      icon: Image(
        image: AssetImage('assets/brands/microsoft32.png'),
      ),
    ),
    BrandList(
      title: "Asus",
      icon: Image(
        image: AssetImage('assets/brands/asus32.png'),
      ),
    ),
    BrandList(
      title: "Logitech",
      icon: Image(
        image: AssetImage('assets/brands/logitech32.png'),
      ),
    ),
    BrandList(
      title: "Corsair",
      icon: Image(
        image: AssetImage('assets/brands/corsair32.png'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Category List",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        child: VerticalTabs(
          tabsWidth: 130,
          itemExtent: 100,
          direction: TextDirection.ltr,
          contentScrollAxis: Axis.vertical,
          changePageDuration: Duration(milliseconds: 500),
          indicatorColor: Colors.purple,
          tabs: <Tab>[
            Tab(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        "Recommended",
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.laptop,
                      size: 32,
                    ),
                    Text("Laptop"),
                  ],
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mouse,
                      size: 32,
                    ),
                    Text("Mouse"),
                  ],
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard,
                      size: 32,
                    ),
                    Text("Keyboard"),
                  ],
                ),
              ),
            ),
          ],
          contents: <Widget>[
            tabsContent(
              'Recommended',
            ),
            tabsContent(
                'Laptop', brandListContainer(productBrandList, context)),
            tabsContent('Mouse', brandListContainer(mouseBrandList, context)),
            tabsContent(
                'Keyboard', brandListContainer(keyboardBrandList, context)),
          ],
        ),
      )),
    );
  }

  Widget brandListContainer(List<BrandList> brandList, BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GridView.count(
              physics: ClampingScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: brandList.map((brand) {
                return Stack(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            brand.icon,
                            Text(brand.title),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchProductList(
                                  brandId: brand.id,
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabsContent(String caption, [Widget content]) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(
            height: 20,
            color: Colors.black45,
          ),
          content != null ? content : Container(),
        ],
      ),
    );
  }
}
