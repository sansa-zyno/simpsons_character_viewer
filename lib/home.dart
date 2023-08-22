//ignore_for_file: prefer_const_constructors
//ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:anywheretest/constants/api.dart';
import 'package:anywheretest/list_of_characters.dart';
import 'package:anywheretest/models/character.dart';
import 'package:anywheretest/services/http.service.dart';
import 'package:anywheretest/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Character> listOfCharacters = [];

  /*bool isTab(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width >= 600;
  }*/

  getCharacters() async {
    Response response = await HttpService.get(Api.baseUrl);
    Map apiResult = jsonDecode(response.data);
    List relatedTopics = apiResult["RelatedTopics"];
    listOfCharacters =
        relatedTopics.map((element) => Character.fromJson(element)).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: listOfCharacters.isEmpty
              ? Center(child: CircularProgressIndicator())
              : LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return TabView(
                      characters: listOfCharacters,
                    );
                  } else {
                    return ListOfCharacters(
                      characters: listOfCharacters,
                    );
                  }
                })),
    );
  }
}
