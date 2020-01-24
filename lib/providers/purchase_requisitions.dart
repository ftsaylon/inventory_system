/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';

/* --------------------------------- Models --------------------------------- */

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisition.dart';
import 'purchase_requisition_items.dart';

class PurchaseRequisitions with ChangeNotifier {
  List<PurchaseRequisition> _purchaseRequisitions = [
    PurchaseRequisition(
      id: 'PR-000001',
      location: 'Cavite',
      department: 'Information Technology',
      project: 'Project Pegasus',
      purchaseRequisitionItems:
          PurchaseRequisitionItems(requisitionId: 'PR-000001'),
      dateRequired: DateTime.now().add(Duration(days: 10)),
      description: 'This is a test purchase requisition.',
      totalEstimatedCost: '0',
      requestedBy: 'Francis Saylon',
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: 'Donuth Torreda',
      status: 'pending',
    ),
    PurchaseRequisition(
      id: 'PR-000002',
      location: 'Cavite',
      department: 'Accounting',
      project: 'Project Pegasus',
      purchaseRequisitionItems:
          PurchaseRequisitionItems(requisitionId: 'PR-000002'),
      dateRequired: DateTime.now().add(Duration(days: 10)),
      description: 'This is a test purchase requisition.',
      totalEstimatedCost: '0',
      requestedBy: 'Rechelle Porto',
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: 'Donuth Torreda',
      status: 'pending',
    ),
    PurchaseRequisition(
      id: 'PR-000003',
      location: 'Cavite',
      department: 'Human Resources',
      project: 'Project Pegasus',
      purchaseRequisitionItems:
          PurchaseRequisitionItems(requisitionId: 'PR-000003'),
      dateRequired: DateTime.now().add(Duration(days: 10)),
      description: 'This is a test purchase requisition.',
      totalEstimatedCost: '0',
      requestedBy: 'Lucenda Torreda',
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: 'Donuth Torreda',
      status: 'pending',
    ),
    PurchaseRequisition(
      id: 'PR-000004',
      location: 'Cavite',
      department: 'Marketing',
      project: 'Project Pegasus',
      purchaseRequisitionItems:
          PurchaseRequisitionItems(requisitionId: 'PR-000004'),
      dateRequired: DateTime.now().add(Duration(days: 10)),
      description: 'This is a test purchase requisition.',
      totalEstimatedCost: '0',
      requestedBy: 'Ramon Catanjal',
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: 'Donuth Torreda',
      status: 'pending',
    ),
    PurchaseRequisition(
      id: 'PR-000005',
      location: 'Cavite',
      department: 'Sales',
      project: 'Project Pegasus',
      purchaseRequisitionItems:
          PurchaseRequisitionItems(requisitionId: 'PR-000005'),
      dateRequired: DateTime.now().add(Duration(days: 10)),
      description: 'This is a test purchase requisition.',
      totalEstimatedCost: '0',
      requestedBy: 'Noel Bautista',
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: 'Donuth Torreda',
      status: 'pending',
    ),
  ];

  List<PurchaseRequisition> get requisitions {
    return [..._purchaseRequisitions];
  }

  PurchaseRequisition findById(String id) {
    return _purchaseRequisitions
        .firstWhere((requisition) => requisition.id == id);
  }

  PurchaseRequisitionItems findByRequisitionId(String id) {
    return findById(id).purchaseRequisitionItems;
  }

  Future<void> addRequisition(PurchaseRequisition purchaseRequisition) async {
    final newRequisition = PurchaseRequisition(
      id: DateTime.now().toString(),
      location: purchaseRequisition.location,
      department: purchaseRequisition.department,
      project: purchaseRequisition.project,
      purchaseRequisitionItems: purchaseRequisition.purchaseRequisitionItems,
      dateRequired: purchaseRequisition.dateRequired,
      description: purchaseRequisition.description,
      totalEstimatedCost: purchaseRequisition.purchaseRequisitionItems.totalEstimatedPrice.toString(),
      requestedBy: purchaseRequisition.requestedBy,
      dateSubmitted: DateTime.now(),
      dateModified: DateTime.now(),
      nextApprover: purchaseRequisition.nextApprover,
      status: purchaseRequisition.status,
    );

    _purchaseRequisitions.add(newRequisition);
    notifyListeners();
  }

  Future<void> updateRequisition(
      String id, PurchaseRequisition newRequisition) async {
    final requisitionIndex =
        _purchaseRequisitions.indexWhere((requisition) => requisition.id == id);

    newRequisition = PurchaseRequisition(
      id: newRequisition.id,
      location: newRequisition.location,
      department: newRequisition.department,
      project: newRequisition.project,
      purchaseRequisitionItems: newRequisition.purchaseRequisitionItems,
      dateRequired: newRequisition.dateRequired,
      description: newRequisition.description,
      totalEstimatedCost: newRequisition.purchaseRequisitionItems.totalEstimatedPrice.toString(),
      requestedBy: newRequisition.requestedBy,
      dateSubmitted: newRequisition.dateSubmitted,
      dateModified: DateTime.now(),
      nextApprover: newRequisition.nextApprover,
      status: newRequisition.status,
    );

    if (requisitionIndex >= 0) {
      _purchaseRequisitions[requisitionIndex] = newRequisition;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteRequisition(String id) async {
    final existingRequisitionIndex =
        _purchaseRequisitions.indexWhere((requisition) => requisition.id == id);
    _purchaseRequisitions.removeAt(existingRequisitionIndex);
    notifyListeners();
  }

  Future<void> deleteRequisitionItem(String requisitionId, String id) async {
    findById(requisitionId).purchaseRequisitionItems.deleteRequisitionItem(id);
    notifyListeners();
  }
}
