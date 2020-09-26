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

//User
import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:ecommerce_flutter/src/redux/user/user_reducer.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';

//Favorite
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_reducer.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_state.dart';

//Address
import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_reducer.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_state.dart';

//Voucher
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_actions.dart';
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_reducer.dart';
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_state.dart';

//Cart
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_reducer.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_state.dart';

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

  if (action is SetUserStateAction) {
    final nextUserState = userReducer(state.userState, action);

    return state.copyWith(userState: nextUserState);
  }

  if (action is SetFavoriteStateAction) {
    final nextFavoriteState = favoriteReducer(state.favoriteState, action);

    return state.copyWith(favoriteState: nextFavoriteState);
  }

  if (action is SetAddressesStateAction) {
    final nextAddressesState = addressesReducer(state.addressesState, action);

    return state.copyWith(addressesState: nextAddressesState);
  }

  if (action is SetVouchersStateAction) {
    final nextVouchersState = vouchersReducer(state.vouchersState, action);

    return state.copyWith(vouchersState: nextVouchersState);
  }

  if (action is SetCartStateAction) {
    final nextCartState = cartReducer(state.cartState, action);

    return state.copyWith(cartState: nextCartState);
  }

  return state;
}

@immutable
//AppState: this is our main state object, the one that holds entire applications state
class AppState {
  final PostsState postsState;
  final ProductsState productsState;
  final UserState userState;
  final FavoriteState favoriteState;
  final AddressesState addressesState;
  final VouchersState vouchersState;
  final CartState cartState;

  AppState({
    @required this.postsState,
    @required this.productsState,
    @required this.userState,
    @required this.favoriteState,
    @required this.addressesState,
    @required this.vouchersState,
    @required this.cartState,
  });

  AppState copyWith({
    PostsState postsState,
    ProductsState productsState,
    UserState userState,
    FavoriteState favoriteState,
    AddressesState addressesState,
    VouchersState vouchersState,
    CartState cartState,
  }) {
    return AppState(
      postsState: postsState ?? this.postsState,
      productsState: productsState ?? this.productsState,
      userState: userState ?? this.userState,
      favoriteState: favoriteState ?? this.favoriteState,
      addressesState: addressesState ?? this.addressesState,
      vouchersState: vouchersState ?? this.vouchersState,
      cartState: cartState ?? this.cartState,
    );
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
    final userStateInitial = UserState.initial();
    final favoriteStateInitial = FavoriteState.initial();
    final addressesStateInitial = AddressesState.initial();
    final vouchersStateInitial = VouchersState.initial();
    final cartStateInitial = CartState.initial();

    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(
        postsState: postsStateInitial,
        productsState: productsStateInitial,
        userState: userStateInitial,
        favoriteState: favoriteStateInitial,
        addressesState: addressesStateInitial,
        vouchersState: vouchersStateInitial,
        cartState: cartStateInitial,
      ),
    );
  }
}
