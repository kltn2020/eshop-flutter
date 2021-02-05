import 'package:ecommerce_flutter/src/models/User.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HelpCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Help Center",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Please contact us if you have any problem"),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Student 1:"),
                    Text(
                      'HUỲNH HẠ VY',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('Number: 16521470'),
                    Text('Phone: 0332935353'),
                    Text('Email: 16521470@gm.uit.edu.vn'),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Student 2:"),
                    Text(
                      'ĐỖ NGỌC BÍCH TRÂM',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('Number: 16521273'),
                    Text('Phone: 0931450328'),
                    Text('Email: 16521273@gm.uit.edu.vn'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
