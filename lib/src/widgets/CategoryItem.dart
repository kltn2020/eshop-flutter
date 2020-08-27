import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final IconData icon;
  final String name;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  CategoryItem(
      {@required this.backgroundColor,
      @required this.size,
      @required this.icon,
      @required this.margin,
      @required this.padding,
      @required this.name,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Icon
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(size),
            ),
            padding: padding,
            margin: margin,
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          //Text
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '$name',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}
