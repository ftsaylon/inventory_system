/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/* -------------------------------- Providers ------------------------------- */

import '../providers/items.dart';

/* --------------------------------- Screens -------------------------------- */

import './edit_item_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';

  final pesoFormat = new NumberFormat.currency(
    locale: 'en_PH',
    decimalDigits: 2,
    symbol: '₱',
  );

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
    final loadedItem = Provider.of<Items>(
      context,
      listen: false,
    ).findById(itemId);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context)
                .pushNamed(EditItemScreen.routeName, arguments: itemId),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(loadedItem.imageUrl),
              ),
              title: Text(
                loadedItem.name,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Quantity'),
              subtitle: Text(
                loadedItem.quantity.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Stock Status'),
              subtitle: Text(
                loadedItem.stockStatus,
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Cost'),
              subtitle: Text(
                pesoFormat.format(double.parse(loadedItem.cost)),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Price'),
              subtitle: Text(
                pesoFormat.format(double.parse(loadedItem.price)),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Item Type'),
              subtitle: Text(
                loadedItem.type,
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Categories'),
              subtitle: Text(
                loadedItem.categories.toString(),
                style: Theme.of(context).textTheme.title,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Description'),
              subtitle: Text(
                loadedItem.description,
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Date Created'),
              subtitle: Text(
                DateFormat.yMEd().add_jms().format(loadedItem.dateCreated),
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            Divider(),
            ListTile(
              title: Text('Date Last Modified'),
              subtitle: Text(
                DateFormat.yMEd().add_jms().format(loadedItem.dateModified),
                style: Theme.of(context).textTheme.body2,
              ),
              dense: true,
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
