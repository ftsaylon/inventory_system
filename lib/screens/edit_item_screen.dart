/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/item.dart';
import '../providers/items.dart';

class EditItemScreen extends StatefulWidget {
  EditItemScreen({Key key}) : super(key: key);

  static const routeName = '/edit-item';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _nameFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _costFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _shortDescriptionFocusNode = FocusNode();
  final _categoriesFocusNode = FocusNode();
  final _quantityFocusNode = FocusNode();
  final _stockStatusFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedItem = Item(
    id: null,
    name: '',
    type: '',
    cost: '',
    price: '',
    description: '',
    shortDescription: '',
    categories: [],
    quantity: 0,
    stockStatus: '',
    dateCreated: null,
    dateModified: null,
    imageUrl: '',
  );

  var _initValues = {
    'id': '',
    'name': '',
    'type': '',
    'cost': '',
    'price': '',
    'description': '',
    'shortDescription': '',
    'categories': [],
    'quantity': 0,
    'stockStatus': '',
    'dateCreated': null,
    'dateModified': null,
    'imageUrl': '',
  };

  var _isInit = true;
  var _isLoading = false;

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final itemId = ModalRoute.of(context).settings.arguments as String;
      if (itemId != null) {
        _editedItem =
            Provider.of<Items>(context, listen: false).findById(itemId);
        _initValues = {
          'name': _editedItem.name,
          'type': _editedItem.type,
          'cost': _editedItem.cost,
          'price': _editedItem.price,
          'description': _editedItem.description,
          'shortDescription': _editedItem.shortDescription,
          'categories': _editedItem.categories,
          'quantity': _editedItem.quantity,
          'stockStatus': _editedItem.stockStatus,
          'dateCreated': _editedItem.dateCreated,
          'dateModified': _editedItem.dateModified,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedItem.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _typeFocusNode.dispose();
    _costFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _shortDescriptionFocusNode.dispose();
    _categoriesFocusNode.dispose();
    _quantityFocusNode.dispose();
    _stockStatusFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
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

    if (_editedItem.id != null) {
      await Provider.of<Items>(context, listen: false).updateItem(
        _editedItem.id,
        _editedItem,
      );
    } else {
      try {
        await Provider.of<Items>(context, listen: false).addItem(
          _editedItem,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_quantityFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: value,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: _editedItem.price,
                          type: _editedItem.type,
                          description: _editedItem.description,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['quantity'].toString(),
                      decoration: InputDecoration(labelText: 'Stock Quantity'),
                      textInputAction: TextInputAction.next,
                      focusNode: _quantityFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_costFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: int.parse(value),
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: _editedItem.price,
                          type: _editedItem.type,
                          description: _editedItem.description,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['cost'],
                      decoration: InputDecoration(labelText: 'Cost'),
                      textInputAction: TextInputAction.next,
                      focusNode: _costFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: value,
                          price: _editedItem.price,
                          type: _editedItem.type,
                          description: _editedItem.description,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_typeFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: value,
                          type: _editedItem.type,
                          description: _editedItem.description,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['type'],
                      decoration: InputDecoration(labelText: 'Type'),
                      textInputAction: TextInputAction.next,
                      focusNode: _typeFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: _editedItem.price,
                          type: value,
                          description: _editedItem.description,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_shortDescriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: _editedItem.price,
                          type: _editedItem.type,
                          description: value,
                          shortDescription: _editedItem.shortDescription,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['shortDescription'],
                      decoration:
                          InputDecoration(labelText: 'Short Description'),
                      textInputAction: TextInputAction.next,
                      focusNode: _shortDescriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_imageUrlFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedItem = Item(
                          id: _editedItem.id,
                          name: _editedItem.name,
                          quantity: _editedItem.quantity,
                          stockStatus: _editedItem.stockStatus,
                          cost: _editedItem.cost,
                          price: _editedItem.price,
                          type: _editedItem.type,
                          description: _editedItem.description,
                          shortDescription: value,
                          categories: _editedItem.categories,
                          dateCreated: _editedItem.dateCreated,
                          dateModified: _editedItem.dateModified,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Center(
                                  child: Text('image'),
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('png') &&
                                  !value.endsWith('jpg') &&
                                  !value.endsWith('jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedItem = Item(
                                id: _editedItem.id,
                                name: _editedItem.name,
                                quantity: _editedItem.quantity,
                                stockStatus: _editedItem.stockStatus,
                                cost: _editedItem.cost,
                                price: _editedItem.price,
                                type: _editedItem.type,
                                description: _editedItem.description,
                                shortDescription: _editedItem.shortDescription,
                                categories: _editedItem.categories,
                                dateCreated: _editedItem.dateCreated,
                                dateModified: _editedItem.dateModified,
                                imageUrl: value,
                              );
                            },
                          ),
                        ),
                      ],
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
