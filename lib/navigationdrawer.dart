import 'package:flutter/material.dart';
import 'package:pokedex/advancesearch.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/scanpokemon.dart';

class Navigationdrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10.0);
  _openPage(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Advancesearch()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Scanpokemon()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Homepage(type1: "None", type2: "None")));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.red,
        child: ListView(
          children: [
            Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.catching_pokemon_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Pokedex Options",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text(
                "Kanto Pokedex",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onTap: () => _openPage(context, 2),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text(
                "Advance search",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onTap: () => _openPage(context, 0),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.scanner),
              title: Text(
                "Pokemon scanner",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onTap: () => _openPage(context, 1),
            )
          ],
        ),
      ),
    );
  }
}
