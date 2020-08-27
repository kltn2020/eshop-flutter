import 'package:ecommerce_flutter/src/animations/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

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

    super.dispose();
  }

  Future<void> _onLogin() async {
    await Redux.store.dispatch(new UserActions(
      email: email.text,
      password: password.text,
    ).loginAction);

    if (Redux.store.state.userState.token != null)
      Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blueGrey[900],
          Colors.blueGrey[800],
          Colors.blueGrey[400]
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
                        "Login",
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
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.teal[100],
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  StoreConnector<AppState, bool>(
                                    distinct: true,
                                    converter: (store) =>
                                        store.state.userState.isLoading,
                                    builder: (context, isLoading) {
                                      if (isLoading) {
                                        return LinearProgressIndicator();
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                  StoreConnector<AppState, bool>(
                                    distinct: true,
                                    converter: (store) =>
                                        store.state.userState.isLoading,
                                    builder: (context, isLoading) {
                                      if (isLoading) {
                                        return LinearProgressIndicator();
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: email,
                                      decoration: InputDecoration(
                                          hintText: "Email ",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      obscureText: true,
                                      controller: password,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            FlatButton(
                                onPressed: () {
                                  _onLogin();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.tealAccent[400]),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.5,
                            Text(
                              "Continue with social media",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // Login by social
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(
                                  1.6,
                                  FlatButton(
                                      onPressed: null,
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text(
                                            "Facebook",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                  1.7,
                                  FlatButton(
                                      onPressed: null,
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white),
                                        child: Center(
                                          child: Text(
                                            "Google",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            FadeAnimation(
                                1.8,
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                  1.9,
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/register');
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.teal[300]),
                                        child: Center(
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))),
                            )
                          ],
                        )
                      ],
                    ),
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
