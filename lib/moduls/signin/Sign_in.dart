import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:flutter/material.dart';

class Sign_in extends StatelessWidget {
  const Sign_in({super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Image.asset(Appassets.logoo,
          height: query.size.height*.25),

      ],),
    );
  }
}
