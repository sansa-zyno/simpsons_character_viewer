//ignore_for_file: prefer_const_constructors
//ignore_for_file: non_constant_identifier_names
//ignore_for_file: prefer_final_fields
import 'package:anywheretest/character_details.dart';
import 'package:anywheretest/models/character.dart';
import 'package:anywheretest/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ListOfCharacters extends StatefulWidget {
  final List<Character> characters;
  const ListOfCharacters({required this.characters, super.key});
  @override
  State<ListOfCharacters> createState() => _ListOfCharactersState();
}

class _ListOfCharactersState extends State<ListOfCharacters> {
  List<Character> _ListOfCharacters = []; // List to store the Characters
  List<Character> _searchResults = []; // List to store search results
  TextEditingController _searchController = TextEditingController();

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
    return Column(
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
                      title: CustomText(text: character.name ?? ""),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    CharacterDetails(character: character)));
                      },
                    );
                  },
                )
              : Center(
                  child: CustomText(text: "No List Of Characters to show")),
        ),
      ],
    );
  }
}
