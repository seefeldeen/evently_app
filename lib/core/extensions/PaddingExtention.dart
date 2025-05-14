import 'package:flutter/material.dart';

extension Paddingextention on Widget {
  Widget Setpadding(double x) {
    return Padding(padding: EdgeInsets.all(x), child: this);
  }

  Widget Sethorizontalpadding(BuildContext context, double x,
      {bool enablemediaquery = true}) {
    var query = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: enablemediaquery ? query.size.width * x : x),
        child: this);
  }

  Widget Setverticalalpadding(BuildContext context, double x,
      {bool enablemediaquery = true}) {
    var query = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: enablemediaquery ? query.size.height * x : x),
        child: this);
  }
  Widget Setoptionalpadding(BuildContext context,
  double t,double b,double r ,double l,
  {bool enablemediaquery = true})
  {
    var query = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(l,t, r,b),
        child: this
            );
  }

  Widget Setresponsivepadding(BuildContext context,
      double t,double b,double r ,double l,
      {bool enablemediaquery = true})
  {
    var query = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(l*query.size.width,
            t*query.size.height,
            r*query.size.width,
            b*query.size.height),
        child: this
    );
  }

}
