import 'package:flutter/material.dart';

class AccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Account Setting",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView(
              children: [
                ListTile(
                  title: Text("Account Info"),
                  onTap: () => {
                    Navigator.pushNamed(context, '/account-info'),
                  },
                ),
                ListTile(
                  title: Text("Address List"),
                  onTap: () => {
                    Navigator.pushNamed(context, '/address-list'),
                  },
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: null,
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
                  "Log Out",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
