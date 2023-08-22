class Character {
  String? name;
  String? title;
  String? desc;
  String? image;

  Character(
      {required this.name,
      required this.title,
      required this.desc,
      required this.image});

  factory Character.fromJson(Map json) => Character(
      name: json["Text"].toString().split("-")[0],
      title: json["Text"].toString().split("-")[0],
      desc: json["Result"].toString(),
      image: json["Icon"]["URL"].toString());
}
