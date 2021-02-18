import 'dart:async';
import 'package:ecommerce_flutter/src/animations/fade_animation.dart';
import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/views/confirm_email.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final email = TextEditingController();
  final password = TextEditingController();
  final repassword = TextEditingController();

  Timer _confirmtimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    email.dispose();
    password.dispose();
    repassword.dispose();
    _confirmtimer.cancel();
    super.dispose();
  }

  void _onRegister() {
    Redux.store.dispatch(new UserActions(
            email: email.text,
            password: password.text,
            passwordConfirmation: repassword.text)
        .resigterAction(Redux.store));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromRGBO(54, 59, 78, 1),
          Color.fromRGBO(79, 59, 120, 1),
          Color.fromRGBO(146, 127, 191, 1),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: StoreConnector<AppState, UserState>(
                    onInit: (store) {
                      store.dispatch(UserActions().resetStateAction);
                    },
                    converter: (store) => store.state.userState,
                    builder: (context, userState) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                              1.4,
                              Column(
                                children: [
                                  //Loading
                                  (() {
                                    if (userState.isLoading) {
                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Color.fromRGBO(
                                              196, 187, 240, 0.5),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color.fromRGBO(146, 127, 191, 1),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }()),
                                  //Error
                                  (() {
                                    if (userState.isError) {
                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: Text(
                                          "Error",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }()),
                                  //Error Message
                                  (() {
                                    if (userState.errorMessage != "") {
                                      var errorMessage = userState.errorMessage;
                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: Text(
                                          "$errorMessage",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }()),
                                  //Success
                                  (() {
                                    if (userState.isSuccess) {
                                      _confirmtimer = new Timer(
                                        Duration(seconds: 3),
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmEmail(
                                                email: email.text,
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: Text(
                                          "Register Successfully. Redirect in seconds....",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }()),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  196, 187, 240, 0.5),
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            controller: email,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Email (ex: example@gmail.com)",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            onEditingComplete: () {
                                              node.nextFocus();
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            obscureText: true,
                                            controller: password,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Password (at least 8 characters)",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            onEditingComplete: () {
                                              node.nextFocus();
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            obscureText: true,
                                            controller: repassword,
                                            decoration: InputDecoration(
                                                hintText: "Re-enter password ",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            onEditingComplete: () {
                                              node.unfocus();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.5,
                                FlatButton(
                                    onPressed: () {
                                      _onRegister();
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(
                                                    146, 127, 191, 1),
                                                Color.fromRGBO(79, 59, 120, 1)
                                              ],
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.tealAccent[400]),
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))),
                            SizedBox(
                              height: 30,
                            ),
                            FadeAnimation(
                              1.6,
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                      },
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        "Back to Login",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
