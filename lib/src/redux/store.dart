import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

//Post
import 'package:ecommerce_flutter/src/redux/posts/posts_actions.dart';
import 'package:ecommerce_flutter/src/redux/posts/posts_reducer.dart';
import 'package:ecommerce_flutter/src/redux/posts/posts_state.dart';

//Product
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/products/products_reducer.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';

//appReducer: the root reducer of our entire application is where we use all of our reducers
AppState appReducer(AppState state, dynamic action) {
  if (action is SetPostsStateAction) {
    final nextPostsState = postsReducer(state.postsState, action);

    return state.copyWith(postsState: nextPostsState);
  }

  if (action is SetProductsStateAction) {
    final nextProductsState = productsReducer(state.productsState, action);

    return state.copyWith(productsState: nextProductsState);
  }

  return state;
}

@immutable
//AppState: this is our main state object, the one that holds entire applications state
class AppState {
  final PostsState postsState;
  final ProductsState productsState;

  AppState({
    @required this.postsState,
    @required this.productsState,
  });

  AppState copyWith({
    PostsState postsState,
    ProductsState productsState,
  }) {
    return AppState(
        postsState: postsState ?? this.postsState,
        productsState: productsState ?? this.productsState);
  }
}

//Redux class: this is just a helper class we’ll be using in our main file to bootstrap redux.
//It has 2 static methods, a getter that we can later use anywhere in our app to access our store and consume it’s data or dispatch actions and an init method that we use to initialize our store.
//We made this a separate async method so maybe later if we needed to persist our state we can read our initial state from some data source (file, database or network) and initialize our store asynchronously.
class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final postsStateInitial = PostsState.initial();
    final productsStateInitial = ProductsState.initial();

    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(
          postsState: postsStateInitial, productsState: productsStateInitial),
    );
  }
}
