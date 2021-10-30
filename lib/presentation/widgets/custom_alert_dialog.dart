import 'package:flutter/material.dart';

Widget showAlertDialog(String title, String content,context) {
  // flutter defined function
  showDialog(
    //barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
          title.toString(),
          style: TextStyle(fontSize: width * .04),
        ),
        content: new Text(
          content,
          style: TextStyle(fontSize: width * .04),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "OK",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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