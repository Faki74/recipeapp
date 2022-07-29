import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/views/recipe_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipes = [];

  TextEditingController textEditingController = new TextEditingController();
  String applicationID = "c418f30c";
  String applicationKey = "c326f454c4325f7eae2dbe3386c119ae";
  getRecipies(String query) async {
    Uri url = Uri.parse(
        "https://api.edamam.com/search?q=$query&app_id=c418f30c&app_key=c326f454c4325f7eae2dbe3386c119ae");
    var response = await http.get(url);
    Map<String, dynamic> JsonData = jsonDecode(response.body);
    JsonData["hits"].forEach((element) {
      print(element.toString());
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipes.add(recipeModel);
    });
    print("${recipes.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color(0xfff03022),
            const Color(0xffa99999),
          ])),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: !kIsWeb
                  ? Platform.isIOS
                      ? 60
                      : 50
                  : 30,
              horizontal: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'What to ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Overpass'),
                    ),
                    Text(
                      'eat',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontFamily: 'Overpass'),
                    ),
                    Text(
                      '?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Overpass'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "What will we cook chef ?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Overpass'),
                ),
                Text(
                  "Tell me what ingredients do you have and i will show you the best recipes ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OverpassRegular'),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Ingredients ?",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: 'Overpass'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () async {
                          if (textEditingController.text.isNotEmpty) {
                            getRecipies(textEditingController.text);
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        )
      ],
    ));
  }
}
