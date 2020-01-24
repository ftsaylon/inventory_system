/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_system/providers/purchase_requisition_items.dart';
import 'package:inventory_system/providers/purchase_requistion_items_list.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/* -------------------------------- Providers ------------------------------- */

import './providers/items.dart';
import './providers/purchase_requisition.dart';
import './providers/purchase_requisitions.dart';

/* --------------------------------- Screens -------------------------------- */

import './screens/item_list_screen.dart';
import './screens/item_detail_screen.dart';
import './screens/edit_item_screen.dart';
import './screens/purchase_requisition_list_screen.dart';
import './screens/edit_purchase_requisition_screen.dart';
import './screens/purchase_requisition_detail_screen.dart';
import './screens/purchase_requisition_item_list_screen.dart';
import 'helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Items(),
        ),
        ChangeNotifierProvider.value(
          value: PurchaseRequisition(),
        ),
        ChangeNotifierProvider.value(
          value: PurchaseRequisitions(),
        ),
        ChangeNotifierProvider.value(
          value: PurchaseRequisitionItems(),
        ),
        ChangeNotifierProvider.value(
          value: PurchaseRequisitionItemsList(),
        ),
      ],
      child: MaterialApp(
        title: 'Inventory System',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
          // textTheme: GoogleFonts.openSansTextTheme(),
        ),
        home: PurchaseRequisitionListScreen(),
        routes: {
          ItemListScreen.routeName: (context) => ItemListScreen(),
          ItemDetailScreen.routeName: (context) => ItemDetailScreen(),
          EditItemScreen.routeName: (context) => EditItemScreen(),
          PurchaseRequisitionListScreen.routeName: (context) =>
              PurchaseRequisitionListScreen(),
          EditPurchaseRequisitionScreen.routeName: (context) =>
              EditPurchaseRequisitionScreen(),
          PurchaseRequisitionDetailScreen.routeName: (context) =>
              PurchaseRequisitionDetailScreen(),
          PurchaseRequisitionItemListScreen.routeName: (context) =>
              PurchaseRequisitionItemListScreen(),
        },
      ),
    );
  }
}
