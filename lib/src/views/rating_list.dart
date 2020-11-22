import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Rating.dart';
import 'package:ecommerce_flutter/src/redux/ratings/ratings_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class RatingList extends StatefulWidget {
  // static String get routeName => '@routes/home-page';
  final int productId;

  RatingList({Key key, this.productId}) : super(key: key);

  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Rating List",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        // actions: [
        //   FlatButton(
        //     onPressed: () => {
        //       Navigator.pushNamed(context, '/rating-create'),
        //     },
        //     child: Row(
        //       children: [
        //         Icon(Icons.add),
        //         Text(
        //           "CREATE",
        //           style: TextStyle(
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: projectWidget(),
    );
  }
}

Widget projectWidget() {
  return FutureBuilder(
    future: Redux.store
        .dispatch(RatingActions().getAllRatingAction(Redux.store, 10, '')),
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      if (projectSnap.connectionState == ConnectionState.waiting) {
        return LinearProgressIndicator(
          backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(146, 127, 191, 1),
          ),
        );
      }
      return Container(
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
                child: StoreConnector<AppState, List<Rating>>(
                  distinct: true,
                  converter: (store) => store.state.ratingState.ratingList,
                  builder: (context, ratings) {
                    return Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ratings.map((rating) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => RatingDetail(
                                //         rating: rating,
                                //       ),
                                //     ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
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
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  child: Text(rating.userEmail),
                                                ),
                                                Row(
                                                  children:
                                                      new List(rating.point)
                                                          .map((e) {
                                                    return Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                    );
                                                  }).toList(),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  child: Text(
                                                      rating.content != null
                                                          ? rating.content
                                                          : ''),
                                                ),
                                                Text(
                                                  rating.updatedAt != null
                                                      ? rating.updatedAt
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
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      );
    },
  );
}
