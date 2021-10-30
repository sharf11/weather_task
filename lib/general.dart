import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class General {

  static Color kMainColor = Color(0xFFFA8208);
  static Color kSecondaryColor =Color(0xFFFA8208);
  //static Color kUnActiveColor = Colors.grey;
  static Color kUnActiveColor = Color(0xFFFFE6AC);
  static Color kOKColor = Color(0xFF2AED33);
  static Color kPendingColor = Color(0xFFFA8208);
  static Color kClosedColor = Color(0xFFFA8208);

  static sizeBoxHorizontial(space) {
    return SizedBox(
      width: space,
    );
  }

  static sizeBoxVerical(space) {
    return SizedBox(
      height: space,
    );
  }

  static buildTxt(
      {@required String txt,
        Color color = Colors.grey,
        double fontSize,
        double lineHeight = 1,
        bool isBold = false,
        bool isOverflow = false,
        bool isUnderLine = false,
        isCenter = true
      }) {
    return Text(
      txt,
      textAlign: isCenter ? TextAlign.center : null,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      style: TextStyle(
        //decoration: TextDecoration.underline,
          color: color,
          height: lineHeight,
          fontFamily: "Montserrat",
          decoration: isUnderLine ? TextDecoration.underline : null,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  static dismissLoadingDialog(context) {
    if (Navigator.of(context).canPop()) Navigator.pop(context);
  }

  static Future<void> showMakeSureDialogue(
      {@required String txt,
        @required BuildContext context,
        Function onPress}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                sizeBoxVerical(10.0),
                buildTxt(
                    txt: txt,
                    fontSize: 13.0,
                    lineHeight: 1.3,
                    color: Colors.black)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: onPress,
            ),
          ],
        );
      },
    );
  }

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
}
