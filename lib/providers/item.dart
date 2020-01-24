/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/foundation.dart';

class Item with ChangeNotifier {
  final String id; // PR
  final String sku; // PR
  final String name; // PR
  int quantity; // PR
  final String unitType; // PR
  // final String estimatedPrice; // PR -> price
  final String preferredSupplier; // PR
  final String size; // PR
  final String comments; // PR
  final String barcode; 
  final String type; 
  final String cost; 
  final String price;
  final String description; 
  final String shortDescription;
  final List<Object> categories;
  String stockStatus;
  final DateTime dateCreated;
  DateTime dateModified;
  final String imageUrl;
  bool isInInventory;


  Item({
    this.id,
    this.sku,
    this.name,
    this.quantity,
    this.unitType,
    // this.estimatedPrice,
    this.preferredSupplier,
    this.size,
    this.comments,
    this.barcode,
    this.cost,
    this.price,
    this.type,
    this.description,
    this.shortDescription,
    this.categories,
    this.stockStatus,
    this.dateCreated,
    this.dateModified,
    this.imageUrl,
    this.isInInventory,
  });

  void increaseQuantity(int quantityToBeAdded) {
    this.quantity += quantityToBeAdded;
    notifyListeners();
  }

  void decreaseQuantity(int quantityToBeDeducted) {
    this.quantity -= quantityToBeDeducted;
    notifyListeners();
  }
}
