import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Rating.dart';
import 'package:ecommerce_flutter/src/redux/ratings/ratings_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetRatingStateAction {
  final RatingState ratingState;

  SetRatingStateAction(this.ratingState);
}

class RatingActions {
  String token;
  Product product;
  int page;
  int size;

  RatingActions({
    this.token,
    this.product,
    this.page,
    this.size,
  });

  Future<void> getAllRatingAction(
      Store<AppState> store, int productId, int page, int size) async {
    store.dispatch(SetRatingStateAction(RatingState(isLoading: true)));

    print('get-rating-list');
    try {
      var token = store.state.userState.token;

      final response = await http.get(
        '$backendUrl/products/$productId/reviews?size=$size',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        store.dispatch(
          SetRatingStateAction(
            RatingState(
              isLoading: false,
              isSuccess: true,
              ratingList: Rating.listFromJson(jsonData['entries']),
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(
          SetRatingStateAction(RatingState(isLoading: false, isError: true)));
    }
  }

  Future<void> addRatingAction(Store<AppState> store, int productId,
      String content, int ratingPoint) async {
    print("add-rating-action");
    store.dispatch(SetRatingStateAction(RatingState(isLoading: true)));

    String token = store.state.userState.token;
    String productID = productId.toString();

    print(jsonEncode(<String, dynamic>{
      'point': ratingPoint,
      'content': content,
    }));
    try {
      final response = await http.post(
        '$backendUrl/products/$productID/reviews',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          'point': ratingPoint,
          'content': content,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        var newRatingList =
            new List<Rating>.from(store.state.ratingState.ratingList)
              ..insert(0, Rating.fromJson(jsonData['data']));

        store.dispatch(
          SetRatingStateAction(
            RatingState(
              isLoading: false,
              isSuccess: true,
              ratingList: newRatingList,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetRatingStateAction(RatingState(isLoading: false, isError: true)));
    }
  }

  // Future<void> deleteRatingAction(Store<AppState> store) async {
  //   print("delete-rating-action");
  //   store.dispatch(SetRatingStateAction(RatingState(isLoading: true)));

  //   String productID = product.id.toString();

  //   try {
  //     final response = await http.delete(
  //       '$backendUrl/products/$productID/like',
  //       headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  //     );

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       print(jsonData);

  //       Rating newRatingList = store.state.ratingState.ratingList;

  //       // newRatingList.product
  //       //     .removeWhere((iproduct) => iproduct.id == product.id);

  //       store.dispatch(
  //         SetRatingStateAction(
  //           RatingState(
  //             isLoading: false,
  //             isSuccess: true,
  //             ratingList: newRatingList,
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (error) {
  //     print(error);
  //     store.dispatch(
  //         SetRatingStateAction(RatingState(isLoading: false, isError: true)));
  //   }
  // }
}
