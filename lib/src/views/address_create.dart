import 'package:flutter/material.dart';

class AddressCreate extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  AddressCreate({Key key}) : super(key: key);

  @override
  _AddressCreateState createState() => _AddressCreateState();
}

class _AddressCreateState extends State<AddressCreate> {
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];

  String _currentCitySelectedValue = "Food";
  String _currentDistrictSelectedValue = "Food";

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
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Number',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'City',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: _currentCitySelectedValue == null,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentCitySelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentCitySelectedValue = newValue;
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'District',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: _currentDistrictSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentDistrictSelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentDistrictSelectedValue = newValue;
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Color.fromRGBO(146, 127, 191, 1),
                  labelText: 'Address',
                ),
              ),
              SizedBox(
                height: 30,
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
