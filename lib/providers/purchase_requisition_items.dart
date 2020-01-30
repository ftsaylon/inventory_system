import 'package:flutter/material.dart';
import 'package:inventory_system/providers/purchase_requisition_item.dart';

class PurchaseRequisitionItems with ChangeNotifier {
  final String requisitionId;

  PurchaseRequisitionItems({this.requisitionId});

  Map<String, PurchaseRequisitionItem> _requisitionItems = {};

  Map<String, PurchaseRequisitionItem> get items {
    return {..._requisitionItems};
  }

  void addItem(PurchaseRequisitionItem item) {
    if (_requisitionItems.containsKey(item.itemId)) {
      _requisitionItems.update(
        item.itemId,
        (existingRequisitionItem) => PurchaseRequisitionItem(
          id: existingRequisitionItem.id,
          itemId: existingRequisitionItem.itemId,
          name: existingRequisitionItem.name,
          preferredSupplier: existingRequisitionItem.preferredSupplier,
          sku: existingRequisitionItem.sku,
          quantity: existingRequisitionItem.quantity + 1,
          unitType: existingRequisitionItem.unitType,
          estimatedPrice: existingRequisitionItem.estimatedPrice,
          size: existingRequisitionItem.size,
          isPreApproved: existingRequisitionItem.isPreApproved,
          comments: existingRequisitionItem.comments,
        ),
      );
    } else {
      _requisitionItems.putIfAbsent(
        item.itemId,
        () => PurchaseRequisitionItem(
          id: DateTime.now().toString(),
          itemId: item.itemId,
          name: item.name,
          preferredSupplier: item.preferredSupplier,
          sku: item.sku,
          quantity: 1,
          unitType: item.unitType,
          estimatedPrice: item.estimatedPrice,
          size: item.size,
          isPreApproved: item.isPreApproved,
          comments: item.comments,
        ),
      );
    }
    notifyListeners();
  }

  double get totalEstimatedPrice {
    var total = 0.0;
    _requisitionItems.forEach((key, requisitionItem) {
      total += double.parse(requisitionItem.estimatedPrice) * requisitionItem.quantity;
    });
    return total;
  }

  Future<void> deleteRequisitionItem(String id) async {
    _requisitionItems.remove(id);
    notifyListeners();
  }
}
