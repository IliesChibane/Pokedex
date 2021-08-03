// @dart = 2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

// ignore: must_be_immutable
class PokeDetail extends StatefulWidget {
  Pokemon pokemon;

  PokeDetail({this.pokemon});

  @override
  _PokeDetailState createState() => _PokeDetailState();

}

class _PokeDetailState extends State<PokeDetail> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  List<String> _pokemonStack = [];
  
  nextpokemon(var currentId,var n) async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    for(int i = currentId;i<pokeHub.pokemon.length;i++)
    {
      var p = pokeHub.pokemon[i];
      if(p.name == n.name )
      {
        _pokemonStack.add(widget.pokemon.name);
        widget.pokemon = p;
        break;
      }
    }
    setState(() {});
  }

  prepokemon(var currentId) async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    if(currentId<0)
      currentId = 0;
    for(int i = currentId;i<pokeHub.pokemon.length;i++)
    {
      var p = pokeHub.pokemon[i];
      if(p.name == _pokemonStack[_pokemonStack.length-1] )
      {
        _pokemonStack.removeAt(_pokemonStack.length-1);
        widget.pokemon = p;
        break;
      }
    }
    setState(() {});
  }
  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    widget.pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: ${widget.pokemon.height}"),
                  Text("Weight: ${widget.pokemon.weight}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Weakness",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses
                        .map((t) => FilterChip(
                            backgroundColor: Colors.red,
                            label: Text(
                              t,
                              style: TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Next Evolution",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution == null
                        ? <Widget>[Text("This is the final form")]
                        : widget.pokemon.nextEvolution
                            .map((n) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    n.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {
                                    nextpokemon(widget.pokemon.id,n);
                                  },
                                ))
                            .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: widget.pokemon.img,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(widget.pokemon.img))),
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text(widget.pokemon.name),
        actions: _pokemonStack.isNotEmpty ? [
          IconButton(
            onPressed: () =>prepokemon(widget.pokemon.id-3), 
            icon: Icon(Icons.arrow_back))
        ] : [],
      ),
      body: bodyWidget(context),
    );
  }
}