import 'package:events/main.dart';
import 'package:flutter/material.dart';

extension Paddingextention on Widget {
  Widget Setpadding(double x) {
    return Padding(child: this, padding: EdgeInsets.all(x));
  }

  Widget Sethorizontalpadding(BuildContext context, double x,
      {bool enablemediaquery = true}) {
    var query = MediaQuery.of(context);
    return Padding(
        child: this,
        padding: EdgeInsets.symmetric(
            horizontal: enablemediaquery ? query.size.width * x : x));
  }

  Widget Setverticalalpadding(BuildContext context, double x,
      {bool enablemediaquery = true}) {
    var query = MediaQuery.of(context);
    return Padding(
        child: this,
        padding: EdgeInsets.symmetric(
            horizontal: enablemediaquery ? query.size.height * x : x));
  }
  Widget Setoptionalpadding(BuildContext context,
  double t,double b,double r ,double l,
  {bool enablemediaquery = true})
  {
    var query = MediaQuery.of(context);
    return Padding(
        child: this,
        padding: EdgeInsets.fromLTRB(l,t, r,b)
            );
  }
}
