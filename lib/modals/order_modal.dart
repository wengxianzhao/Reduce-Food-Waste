import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

OrderModal orderModalFromJson(String str) =>
    OrderModal.fromJson(json.decode(str));

String orderModalToJson(OrderModal data) => json.encode(data.toJson());

class OrderModal {
  OrderModal({
    required this.id,
    required this.users,
    required this.quantity,
    required this.price,
    required this.rating,
    required this.createdAt,
    required this.lastActivityAt,
    required this.foodItemId,
    required this.foodItemUploaderID,
    required this.orderBy,
    required this.status,
  });

  String id;
  List<String> users;
  int quantity;
  double price;
  double rating;
  Timestamp createdAt;
  Timestamp lastActivityAt;
  String foodItemId;
  String status;
  String foodItemUploaderID;
  String orderBy;

  factory OrderModal.fromJson(Map<String, dynamic> json) => OrderModal(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"],
        rating: json["rating"],
        createdAt: json["created_at"],
        lastActivityAt: json["last_activity_at"],
        foodItemId: json["food_item_id"],
        status: json["status"],
        foodItemUploaderID: json["food_item_uploader_id"],
        orderBy: json["order_by"],
        users: List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "rating": rating,
        "created_at": createdAt,
        "last_activity_at": lastActivityAt,
        "food_item_id": foodItemId,
        "status": status,
        "food_item_uploader_id": foodItemUploaderID,
        "order_by": orderBy,
        "users": List<String>.from(users.map((x) => x)),
      };
}
