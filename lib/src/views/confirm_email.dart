import 'dart:async';

import 'package:ecommerce_flutter/src/animations/fade_animation.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';
import 'package:ecommerce_flutter/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmEmail extends StatefulWidget {
  ConfirmEmail({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  final token1 = TextEditingController();
  final token2 = TextEditingController();
  final token3 = TextEditingController();
  final token4 = TextEditingController();
  final token5 = TextEditingController();
  final token6 = TextEditingController();
  final emailInput = TextEditingController();

  Timer _logintimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    token1.dispose();
    token2.dispose();
    token3.dispose();
    token4.dispose();
    token5.dispose();
    token6.dispose();
    emailInput.dispose();

    super.dispose();
  }

  Future<void> _onConfirmEmail() async {
    var tokenCode = token1.text.toUpperCase() +
        token2.text.toUpperCase() +
        token3.text.toUpperCase() +
        token4.text.toUpperCase() +
        token5.text.toUpperCase() +
        token6.text.toUpperCase();

    await Redux.store.dispatch(UserActions().confirmEmailAction(Redux.store,
        tokenCode, widget.email != null ? widget.email : emailInput.text));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    print(widget.email);
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
                        "Confirm Email",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
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
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
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
                                              new AlwaysStoppedAnimation<Color>(
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
                                        margin: EdgeInsets.all(4),
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
                                      _logintimer = new Timer(
                                          const Duration(seconds: 2), () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Login(),
                                          ),
                                        );
                                      });

                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: Text(
                                          "Confirm Successfully. Redirect in seconds....",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }()),

                                  Text(
                                    "We have sent you a mail with token to your registered email, please enter it to vertify",
                                  ),

                                  widget.email == null
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextField(
                                            controller: emailInput,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Email (ex: example@gmail.com)",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            onEditingComplete: () {
                                              node.nextFocus();
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          height: 30,
                                        ),
                                  //Verify token
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          controller: token1,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.nextFocus();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: token2,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.nextFocus();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: token3,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.nextFocus();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: token4,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.nextFocus();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: token5,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.nextFocus();
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: token6,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            counterText: "",
                                          ),
                                          maxLength: 1,
                                          maxLengthEnforced: true,
                                          onChanged: (String value) async {
                                            if (value != '') {
                                              node.unfocus();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  FadeAnimation(
                                      1.5,
                                      FlatButton(
                                          onPressed: () {
                                            _onConfirmEmail();
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        146, 127, 191, 1),
                                                    Color.fromRGBO(
                                                        79, 59, 120, 1)
                                                  ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ))),
                                  SizedBox(
                                    height: 40,
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
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
