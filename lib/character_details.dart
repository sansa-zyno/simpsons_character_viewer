//ignore_for_file: prefer_const_constructors
//ignore_for_file: depend_on_referenced_packages
import 'package:anywheretest/models/character.dart';
import 'package:anywheretest/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_html_css/simple_html_css.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({required this.character, super.key});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Character Details",
            size: 18,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              widget.character.image == ""
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
                          "https://duckduckgo.com/${widget.character.image!}")),
              SizedBox(
                height: 15,
              ),
              CustomText(
                text: widget.character.title!,
                size: 18,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: RichText(
                  text: HTML.toTextSpan(context, widget.character.desc!,
                      defaultTextStyle: TextStyle(
                          decoration: TextDecoration.none, fontSize: 16)),
                  //...
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
