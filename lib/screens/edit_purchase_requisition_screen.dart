/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_system/providers/purchase_requisition_items.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/purchase_requisition.dart';
import '../providers/purchase_requisitions.dart';

/* --------------------------------- Screens -------------------------------- */

import '../screens/item_list_screen.dart';

class EditPurchaseRequisitionScreen extends StatefulWidget {
  EditPurchaseRequisitionScreen({Key key}) : super(key: key);

  static const routeName = '/edit-purchase-requisition';

  @override
  _EditPurchaseRequisitionScreenState createState() =>
      _EditPurchaseRequisitionScreenState();
}

class _EditPurchaseRequisitionScreenState
    extends State<EditPurchaseRequisitionScreen> {
  final _form = GlobalKey<FormState>();

  var _editedRequisition = PurchaseRequisition(
    id: null,
    location: '',
    department: '',
    project: '',
    purchaseRequisitionItems: PurchaseRequisitionItems(),
    dateRequired: null,
    description: '',
    requestedBy: '',
    dateSubmitted: null,
    dateModified: null,
    nextApprover: '',
    status: '',
  );

  var _initValues = {
    'id': '',
    'location': '',
    'department': '',
    'project': '',
    'purchaseRequisitionItems': PurchaseRequisitionItems(),
    'dateRequired': null,
    'description': '',
    'requestedBy': '',
    'dateSubmitted': null,
    'dateModified': null,
    'nextApprover': '',
    'status': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final requisitionId = ModalRoute.of(context).settings.arguments as String;
      if (requisitionId != null) {
        _editedRequisition = Provider.of<PurchaseRequisitions>(
          context,
          listen: false,
        ).findById(requisitionId);
        _initValues = {
          'id': _editedRequisition.id,
          'location': _editedRequisition.location,
          'department': _editedRequisition.department,
          'project': _editedRequisition.project,
          'purchaseRequisitionItems':
              _editedRequisition.purchaseRequisitionItems,
          'dateRequired': _editedRequisition.dateRequired,
          'description': _editedRequisition.description,
          'requestedBy': _editedRequisition.requestedBy,
          'dateSubmitted': _editedRequisition.dateSubmitted,
          'dateModified': _editedRequisition.dateModified,
          'nextApprover': _editedRequisition.nextApprover,
          'status': _editedRequisition.status,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedRequisition.id != null) {
      await Provider.of<PurchaseRequisitions>(context, listen: false)
          .updateRequisition(
        _editedRequisition.id,
        _editedRequisition,
      );
    } else {
      try {
        await Provider.of<PurchaseRequisitions>(context, listen: false)
            .addRequisition(
          _editedRequisition,
        );
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _editedRequisition = PurchaseRequisition(
          id: _editedRequisition.id,
          location: _editedRequisition.location,
          department: _editedRequisition.department,
          project: _editedRequisition.project,
          purchaseRequisitionItems: _editedRequisition.purchaseRequisitionItems,
          dateRequired: pickedDate,
          description: _editedRequisition.description,
          requestedBy: _editedRequisition.requestedBy,
          dateSubmitted: _editedRequisition.dateSubmitted,
          dateModified: _editedRequisition.dateModified,
          nextApprover: _editedRequisition.nextApprover,
          status: _editedRequisition.status,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _editedRequisition.id != null ? Text(_editedRequisition.id) : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['location'],
                      decoration: InputDecoration(labelText: 'Location'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: value,
                          department: _editedRequisition.department,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['department'],
                      decoration: InputDecoration(labelText: 'Department'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: value,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['project'],
                      decoration: InputDecoration(labelText: 'Project'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: _editedRequisition.department,
                          project: value,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: _editedRequisition.department,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: value,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['requestedBy'],
                      decoration: InputDecoration(labelText: 'Requested By'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: _editedRequisition.department,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: value,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['nextApprover'],
                      decoration: InputDecoration(labelText: 'Next Approver'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: _editedRequisition.department,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: value,
                          status: _editedRequisition.status,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['status'],
                      decoration: InputDecoration(labelText: 'Status'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRequisition = PurchaseRequisition(
                          id: _editedRequisition.id,
                          location: _editedRequisition.location,
                          department: _editedRequisition.department,
                          project: _editedRequisition.project,
                          purchaseRequisitionItems:
                              _editedRequisition.purchaseRequisitionItems,
                          dateRequired: _editedRequisition.dateRequired,
                          description: _editedRequisition.description,
                          requestedBy: _editedRequisition.requestedBy,
                          dateSubmitted: _editedRequisition.dateSubmitted,
                          dateModified: _editedRequisition.dateModified,
                          nextApprover: _editedRequisition.nextApprover,
                          status: value,
                        );
                      },
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _editedRequisition.dateRequired == null
                                  ? 'Date Required'
                                  : 'Date Required: ${DateFormat.yMd().format(_editedRequisition.dateRequired)}',
                            ),
                          ),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text("Add Item From Catalog"),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ItemListScreen.routeName,
                          arguments: {
                            'requisitionId': _editedRequisition.id,
                            'addingFromCatalog': true,
                            'purchaseRequisitionItems':
                                _editedRequisition.purchaseRequisitionItems,
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: _saveForm,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
