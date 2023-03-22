import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.restaurantId,
    required this.userId,
    required this.name,
    required this.mapLink,
    required this.location,
    required this.phoneNumber,
  });

  int restaurantId;
  int userId;
  String name;
  String? mapLink;
  String location;
  String phoneNumber;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        restaurantId: json["restaurant_id"],
        userId: json["user_id"],
        name: json["name"],
        mapLink: json["map_link"],
        location: json["location"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "user_id": userId,
        "name": name,
        "map_link": mapLink,
        "location": location,
        "phone_number": phoneNumber,
      };
}
