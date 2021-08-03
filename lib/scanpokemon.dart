import 'package:flutter/material.dart';

import 'navigationdrawer.dart';

class Scanpokemon extends StatelessWidget {
  const Scanpokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advance Search"),
        backgroundColor: Colors.red,
      ),
      drawer: Navigationdrawer(),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_rounded,
            color: Colors.red,
            size: 50,
          ),
          Text(
            "Coming soon......",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
          )
        ],
      )),
    );
  }
}
