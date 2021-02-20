import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/User.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:ecommerce_flutter/src/views/category_list.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:ecommerce_flutter/src/widgets/BottomNavigation.dart';
import 'package:ecommerce_flutter/src/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import '../widgets/CategoryItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token == null) {
      Navigator.pushReplacementNamed(context, '/intro');
      return;
    } else {
      Redux.store.state.userState.token = token;
      Redux.store.state.userState.user = User.fromJson(parseJwtPayLoad(token));
      Navigator.pushReplacementNamed(context, '/');

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: projectWidget(),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      future: Future.wait(<Future>[
        autoLogIn().then((_) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          Redux.store.dispatch(
              CartActions().getAllCartAction(Redux.store).catchError((_) {
            if (prefs.getString('token') == null) {
              Navigator.pushReplacementNamed(context, '/intro');
              return;
            }
          }));
          Redux.store.dispatch(ProductActions()
              .getCollaborativeRecommendAction(Redux.store, 1, 20));
        }),
      ]),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        if (projectSnap.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              Text(
                "Eshop",
                style: TextStyle(
                  color: Color.fromRGBO(79, 59, 120, 1),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                ),
              ),
            ],
          );
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(146, 127, 191, 1),
                  ),
                ),
                height: 70.0,
                width: 70.0,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Eshop",
                style: TextStyle(
                  color: Color.fromRGBO(79, 59, 120, 1),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
