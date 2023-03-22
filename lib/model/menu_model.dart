import 'dart:convert';

List<MenuModel> menuModelFromJson(String str) =>
    List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String menuModelToJson(List<MenuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel {
  MenuModel({
    required this.dishId,
    required this.name,
    required this.description,
    required this.price,
    required this.isSpecial,
    required this.createdOn,
    required this.updatedOn,
    required this.restaurant,
  });

  int dishId;
  String name;
  String description;
  String price;
  bool isSpecial;
  DateTime createdOn;
  DateTime updatedOn;
  int restaurant;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        dishId: json["dish_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        isSpecial: json["isSpecial"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedOn: DateTime.parse(json["updatedOn"]),
        restaurant: json["restaurant"],
      );

  Map<String, dynamic> toJson() => {
        "dish_id": dishId,
        "name": name,
        "description": description,
        "price": price,
        "isSpecial": isSpecial,
        "createdOn": createdOn.toIso8601String(),
        "updatedOn": updatedOn.toIso8601String(),
        "restaurant": restaurant,
      };
}

class MenuItem {
  final int dishId;
  final String name;
  final String description;
  final String price;
  final bool isSpecial;
  final String createdOn;
  final String updatedOn;
  final int restaurant;

  MenuItem({
    required this.dishId,
    required this.name,
    required this.description,
    required this.price,
    required this.isSpecial,
    required this.createdOn,
    required this.updatedOn,
    required this.restaurant,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      dishId: json['dish_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      isSpecial: json['isSpecial'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      restaurant: json['restaurant'],
    );
  }
}
