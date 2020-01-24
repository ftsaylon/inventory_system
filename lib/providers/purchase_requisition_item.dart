/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';

class PurchaseRequisitionItem with ChangeNotifier{
  final String id;
  final String itemId;
  final String sku;
  final String name;
  int quantity;
  final String unitType;
  final String estimatedPrice;
  final String preferredSupplier;
  final String size;
  bool isPreApproved;
  final String comments;

  PurchaseRequisitionItem({
    @required this.id,
    @required this.itemId,
    @required this.name,
    @required this.preferredSupplier,
    @required this.sku,
    @required this.quantity,
    @required this.unitType,
    @required this.estimatedPrice,
    @required this.size,
    @required this.isPreApproved,
    @required this.comments,
  });
}
