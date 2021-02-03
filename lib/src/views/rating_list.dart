import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/redux/ratings/ratings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  int page = 1;

  Widget projectWidget() {
    return Container(
      child: StoreConnector<AppState, RatingState>(
        distinct: true,
        converter: (store) => store.state.ratingState,
        onInitialBuild: Redux.store.dispatch(RatingActions()
            .getAllRatingAction(Redux.store, widget.productId, page, 20)),
        builder: (context, ratingState) {
          return Container(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!ratingState.isLoading &&
                    scrollInfo is ScrollEndNotification &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    page += 1;
                  });
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ratingState.ratingList.map((rating) {
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    color: Color.fromRGBO(146, 127, 191, 1),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      rating.userEmail[0].toUpperCase(),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(rating.userEmail),
                                        ),
                                        RatingBarIndicator(
                                          rating: rating.point != null
                                              ? rating.point.toDouble()
                                              : 0.0,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(rating.content != null
                                              ? rating.content
                                              : ''),
                                        ),
                                        Text(
                                          rating.updatedAt != null
                                              ? rating.updatedAt
                                              : '',
                                          style: TextStyle(color: Colors.grey),
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
            ),
          );
        },
      ),
    );
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
