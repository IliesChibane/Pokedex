// @dart = 2.9
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/navigationdrawer.dart';
import 'package:pokedex/pokemondetail.dart';
import 'pokemon.dart';

void main() => runApp(MaterialApp(
      title: "Pokedex",
      home: Homepage(type1: "None",type2: "None"),
      debugShowCheckedModeBanner: false,
    ));

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
  var type1,type2;
  Homepage({Key key, @required this.type1, @required this.type2});
}

class _HomepageState extends State<Homepage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  var _searchPokemon;

  @override
  void initState() {
    super.initState();

    fetchData(widget.type1,widget.type2);
    _searchPokemon = TextEditingController();
  }

  @override
  void dispose() {
    _searchPokemon.dispose();
    super.dispose();
  }

  fetchData(String t1, String t2) async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    List<String> types = [];
    // ignore: unnecessary_statements
    (t1 == "None") ? {} : types.add(t1);
    // ignore: unnecessary_statements
    (t2 == "None") ? {} : types.add(t2);
    if(types.isNotEmpty)
    {
      // ignore: await_only_futures
      List<Pokemon> p = await pokeHub.pokemon.toList();
      
      p = p.where((poke) => listEquals(poke.type,types)).toList();
      pokeHub.pokemon = p;
    }
    setState(() {});
  }

  filterData() async{
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    // ignore: await_only_futures
    List<Pokemon> p = await pokeHub.pokemon.toList();
    String name = "${_searchPokemon.text[0].toUpperCase()}${_searchPokemon.text.substring(1).toLowerCase()}";
    p = p.where((poke) => poke.name.contains(name) || poke.name.contains(name.toLowerCase())).toList();
    pokeHub.pokemon = p;
    _searchPokemon.text = '';
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () => fetchData("None","None"), 
            icon: Icon(Icons.refresh_rounded),
            )
        ],
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )))
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Navigationdrawer(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.search),
          onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.red,
              builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  //height: 200,
                  //alignment: Alignment.center,
                  //color: Colors.red,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Search a pokemon :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _searchPokemon,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter the pokemon name",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              filterData();
                            },
                            icon: Icon(
                              Icons.catching_pokemon,
                              size: 30,
                              color: Colors.white,
                            ),
                            label: Text(
                              "search",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          )
                        ],
                      )
                    ],
                  )))),
    );
  }
}
