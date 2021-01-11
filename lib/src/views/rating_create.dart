import 'package:ecommerce_flutter/src/redux/ratings/ratings_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class ReviewCreate extends StatefulWidget {
  final int productId;

  ReviewCreate({Key key, this.productId}) : super(key: key);

  @override
  _ReviewCreateState createState() => _ReviewCreateState();
}

class _ReviewCreateState extends State<ReviewCreate> {
  final TextEditingController _contentController = TextEditingController();
  int ratingPoint;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _onCreate() async {
    await RatingActions()
        .addRatingAction(
      Redux.store,
      widget.productId,
      _contentController.text,
      ratingPoint,
    )
        .then((_) {
      Navigator.pop(context);
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
          "Review Create",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingPoint = rating.toInt();
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Content',
                ),
                maxLines: 4,
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  _onCreate();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(146, 127, 191, 1),
                      Color.fromRGBO(79, 59, 120, 1)
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  ),
                  child: Center(
                    child: Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
