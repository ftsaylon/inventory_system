/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:inventory_system/providers/purchase_requisition_items.dart';

/* --------------------------------- Models --------------------------------- */

import '../providers/purchase_requisition_item.dart';

class PurchaseRequisition with ChangeNotifier {
  final String id;
  final String location;
  final String department;
  final String project;
  PurchaseRequisitionItems purchaseRequisitionItems;
  final DateTime dateRequired;
  final String description;
  final String totalEstimatedCost;
  final String requestedBy;
  final DateTime dateSubmitted;
  DateTime dateModified;
  final String nextApprover;
  final String status;

  PurchaseRequisition({
    this.id,
    this.location,
    this.department,
    this.project,
    this.purchaseRequisitionItems,
    this.dateRequired,
    this.description,
    this.totalEstimatedCost,
    this.requestedBy,
    this.dateSubmitted,
    this.dateModified,
    this.nextApprover,
    this.status,
  });

  
}
