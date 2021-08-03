import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'main.dart';
import 'navigationdrawer.dart';

class Advancesearch extends StatefulWidget {
  Advancesearch({Key? key}) : super(key: key);

  @override
  _AdvancesearchState createState() => _AdvancesearchState();
}

class _AdvancesearchState extends State<Advancesearch> {
  var type1 = "None", type2 = "None";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advance Search"),
        backgroundColor: Colors.red,
      ),
      drawer: Navigationdrawer(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pokemon Type",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  )
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: type1,
                    hint: Text("None"),
                    onChanged: (String? newValue) {
                      setState(() {
                        type1 = newValue!;
                      });
                    },
                    items: <String>[
                      'None',
                      'Grass',
                      'Fire',
                      'Water',
                      'Electric',
                      'Ice',
                      'Flying',
                      'Ground',
                      'Rock',
                      'Psychic',
                      'Bug',
                      'Normal',
                      'Fighting',
                      'Dragon',
                      'Ghost',
                      'Poison'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: type2,
                    hint: Text("None"),
                    onChanged: (String? newValue) {
                      setState(() {
                        type2 = newValue!;
                      });
                    },
                    items: <String>[
                      'None',
                      'Grass',
                      'Fire',
                      'Water',
                      'Electric',
                      'Ice',
                      'Flying',
                      'Ground',
                      'Rock',
                      'Psychic',
                      'Bug',
                      'Normal',
                      'Fighting',
                      'Dragon',
                      'Ghost',
                      'Poison'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(height: 100,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Homepage(type1: type1, type2: type2)));
                      },
                      icon: Icon(
                        Icons.catching_pokemon,
                        size: 30,
                        color: Colors.red,
                      ),
                      label: Text(
                        "search",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
