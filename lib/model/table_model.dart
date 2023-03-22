import 'dart:convert';

List<TableModel> tableModelFromJson(String str) =>
    List<TableModel>.from(json.decode(str).map((x) => TableModel.fromJson(x)));

String tableModelToJson(List<TableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  TableModel({
    required this.tableId,
    required this.noOfSeats,
    required this.isVip,
    required this.price,
    required this.isBooked,
    required this.createdOn,
    required this.restaurant,
  });

  int tableId;
  int noOfSeats;
  bool isVip;
  String price;
  bool isBooked;
  DateTime createdOn;
  int restaurant;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        tableId: json["table_id"],
        noOfSeats: json["no_of_seats"],
        isVip: json["isVIP"],
        price: json["price"],
        isBooked: json["isBooked"],
        createdOn: DateTime.parse(json["createdOn"]),
        restaurant: json["restaurant"],
      );

  Map<String, dynamic> toJson() => {
        "table_id": tableId,
        "no_of_seats": noOfSeats,
        "isVIP": isVip,
        "price": price,
        "isBooked": isBooked,
        "createdOn": createdOn.toIso8601String(),
        "restaurant": restaurant,
      };
}
