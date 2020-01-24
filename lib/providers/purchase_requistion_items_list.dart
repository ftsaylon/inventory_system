import 'package:flutter/material.dart';

import 'purchase_requisition_items.dart';

class PurchaseRequisitionItemsList with ChangeNotifier {
  List<PurchaseRequisitionItems> _items = [
    PurchaseRequisitionItems(requisitionId: 'PR-000001'),
    PurchaseRequisitionItems(requisitionId: 'PR-000002'),
    PurchaseRequisitionItems(requisitionId: 'PR-000003'),
    PurchaseRequisitionItems(requisitionId: 'PR-000004'),
    PurchaseRequisitionItems(requisitionId: 'PR-000005'),
  ];

  PurchaseRequisitionItems findByRequisitionId(String requisitionId) {
    return _items.firstWhere(
        (requisitionItems) => requisitionItems.requisitionId == requisitionId);
  }

  Future<void> addRequisitionItems(
      PurchaseRequisitionItems purchaseRequisitionItems) async {
    final newRequisitionItems = PurchaseRequisitionItems(
      requisitionId: purchaseRequisitionItems.requisitionId,
    );
    
    _items.add(newRequisitionItems);
    notifyListeners();
  }

  Future<void> deleteRequisitionItem(String requisitionId, String id) async {
    final existingRequisitionItemsIndex = _items
        .indexWhere((requisitionItems) => requisitionItems.requisitionId == id);
    _items[existingRequisitionItemsIndex].items.remove(id);
    notifyListeners();
  }
}
