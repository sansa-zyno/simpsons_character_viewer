//ignore_for_file: prefer_const_constructors
//ignore_for_file: non_constant_identifier_names
//ignore_for_file: prefer_final_fields
//ignore_for_file: depend_on_referenced_packages
import 'package:anywheretest/widgets/custom_text.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:anywheretest/models/character.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TabView extends StatefulWidget {
  final List<Character> characters;
  const TabView({required this.characters, super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  List<Character> _ListOfCharacters = []; // List to store the Characters
  List<Character> _searchResults = []; // List to store search results
  TextEditingController _searchController = TextEditingController();

  int index = 0;
  int idx = 0;

  @override
  void initState() {
    super.initState();
    _ListOfCharacters = widget.characters;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults.clear();
      } else {
        _searchResults = _ListOfCharacters.where((character) =>
            character.title?.toLowerCase().contains(query.toLowerCase()) ??
            false).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CustomText(
                text: "List Of Characters",
                size: 18,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _handleSearch,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: _ListOfCharacters.isNotEmpty || _searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchController.text == ""
                            ? _ListOfCharacters.length
                            : _searchResults.length,
                        itemBuilder: (context, index) {
                          final character = _searchController.text == ""
                              ? _ListOfCharacters[index]
                              : _searchResults[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(8),
                            leading: CustomText(text: "${index + 1}"),
                            title: CustomText(text: character.name!),
                            onTap: () {
                              this.index = index;
                              idx = index;
                              setState(() {});
                            },
                          );
                        },
                      )
                    : Center(
                        child:
                            CustomText(text: "No List Of Characters to show")),
              )
            ],
          ),
        ),
        index == idx
            ? Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: "Character Details",
                        size: 18,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _ListOfCharacters[index].image == ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 70,
                                  imageUrl:
                                      "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg"))
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Image.network(
                                  "https://duckduckgo.com/${_ListOfCharacters[index].image!}")),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: "${_ListOfCharacters[index].title}",
                        size: 16,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RichText(
                          text: HTML.toTextSpan(
                              context, _ListOfCharacters[index].desc!,
                              defaultTextStyle: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16)),
                          //...
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
