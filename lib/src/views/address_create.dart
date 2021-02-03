import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class AddressCreate extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  AddressCreate({Key key}) : super(key: key);

  @override
  _AddressCreateState createState() => _AddressCreateState();
}

class _AddressCreateState extends State<AddressCreate> {
  var _isPrimary = [true, false];
  bool _currentIsPrimary = true;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locateController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _locateController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog(void value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Successfully !!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.greenAccent[400],
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/undraw_update_complete.png"),
                Text(
                  "Your address has been created",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Back to Address List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); //pop dialog
                Navigator.of(context).pop(); // pop screen
                Navigator.pushReplacementNamed(context, '/address-list');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(AddressErrorMessage e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Create Error!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/undraw_error.png"),
                Text(
                  e.message.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'I will check it right now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          "Address Create",
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
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     focusColor: Color.fromRGBO(146, 127, 191, 1),
              //     labelText: 'Name',
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _locateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Locate',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FormField<bool>(
                builder: (FormFieldState<bool> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Set as primary address?',
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      hintText: 'IsPrimary',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    isEmpty: _currentIsPrimary == null,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<bool>(
                        value: _currentIsPrimary,
                        isDense: true,
                        onChanged: (bool newValue) {
                          setState(() {
                            _currentIsPrimary = newValue;
                          });
                        },
                        items: _isPrimary.map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value == true ? "Yes" : "No"),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  if (_phoneNumberController.text != "")
                    AddressesActions()
                        .addAddressesAction(
                      Redux.store,
                      Redux.store.state.userState.token,
                      _phoneNumberController.text,
                      _locateController.text,
                      _currentIsPrimary,
                    )
                        .then(
                      (value) => _showSuccessDialog(value),
                      onError: (e) {
                        _showErrorDialog(e);
                      },
                    );
                  else
                    _showErrorDialog(AddressErrorMessage.fromJson({
                      'code': 'VALIATION_ERROR',
                      'message': "Phone number can't be blank",
                      'status': 'ERROR',
                    }));
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
