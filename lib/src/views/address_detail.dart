import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class AddressDetail extends StatefulWidget {
  final Address address;

  AddressDetail({Key key, @required this.address}) : super(key: key);

  @override
  _AddressDetailState createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  var _isPrimary = [true, false];
  bool _currentIsPrimary;

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _locateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // you can use this.widget.foo here
    _currentIsPrimary = this.widget.address.isPrimary;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _locateController.dispose();
    super.dispose();
  }

  _updateAddress(BuildContext context) async {
    AddressesActions()
        .updateAddressesAction(
      Redux.store,
      widget.address.id,
      Redux.store.state.userState.token,
      _phoneNumberController.text,
      _locateController.text,
      _currentIsPrimary,
    )
        .then(
      (value) => _showSuccessDialog(value),
      onError: (e) {
        //_showErrorDialog(e);
      },
    );
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
                  "Your address has been updated",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Address Detail",
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
                controller: _phoneNumberController
                  ..text = widget.address.phoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Phone Number',
                ),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              // FormField<String>(
              //   builder: (FormFieldState<String> state) {
              //     return InputDecorator(
              //       decoration: InputDecoration(
              //           labelStyle: TextStyle(color: Colors.grey),
              //           errorStyle:
              //               TextStyle(color: Colors.redAccent, fontSize: 16.0),
              //           hintText: 'City',
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(5.0))),
              //       isEmpty: _currentCitySelectedValue == null,
              //       child: DropdownButtonHideUnderline(
              //         child: DropdownButton<String>(
              //           value: _currentCitySelectedValue,
              //           isDense: true,
              //           onChanged: (String newValue) {
              //             setState(() {
              //               _currentCitySelectedValue = newValue;
              //             });
              //           },
              //           items: _currencies.map((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value),
              //             );
              //           }).toList(),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // FormField<String>(
              //   builder: (FormFieldState<String> state) {
              //     return InputDecorator(
              //       decoration: InputDecoration(
              //           labelStyle: TextStyle(color: Colors.grey),
              //           errorStyle:
              //               TextStyle(color: Colors.redAccent, fontSize: 16.0),
              //           hintText: 'District',
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(5.0))),
              //       isEmpty: _currentDistrictSelectedValue == '',
              //       child: DropdownButtonHideUnderline(
              //         child: DropdownButton<String>(
              //           value: _currentDistrictSelectedValue,
              //           isDense: true,
              //           onChanged: (String newValue) {
              //             setState(() {
              //               _currentDistrictSelectedValue = newValue;
              //             });
              //           },
              //           items: _currencies.map((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Text(value),
              //             );
              //           }).toList(),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _locateController..text = widget.address.locate,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Address',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FormField<bool>(
                builder: (FormFieldState<bool> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Primary Address?',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      hintText: 'Primary',
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
                            child: Text(value == true ? "True" : "False"),
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
                  _updateAddress(context);
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
                      "Update",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: FlatButton(
                  onPressed: () async {
                    await AddressesActions()
                        .deleteAddressesAction(Redux.store, widget.address.id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
