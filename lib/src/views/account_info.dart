import 'package:ecommerce_flutter/src/models/User.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AccountInfo extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  AccountInfo({Key key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Account Info",
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
        child: StoreConnector<AppState, User>(
            distinct: true,
            converter: (store) => store.state.userState.user,
            builder: (context, user) {
              print(user.id);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        enabled: false,
                        initialValue: user.id.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ID',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        enabled: false,
                        initialValue: user.email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        enabled: false,
                        initialValue: user.role,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Role',
                        ),
                      ),
                    ),

                    // FlatButton(
                    //   onPressed: null,
                    //   child: Container(
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       gradient: LinearGradient(colors: [
                    //         Color.fromRGBO(146, 127, 191, 1),
                    //         Color.fromRGBO(79, 59, 120, 1)
                    //       ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         "Change Password",
                    //         style: TextStyle(
                    //             color: Colors.white, fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
