/* -------------------------------- Packages -------------------------------- */

import 'package:flutter/material.dart';

/* -------------------------------- Providers ------------------------------- */
import './item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    Item(
      id: "33a4b859-62ae-4d02-8cf9-a26db06559dd",
      name: "Bread - Mini Hamburger Bun",
      type: "simple",
      cost: "18",
      price: "27",
      description:
          "Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.",
      shortDescription:
          "cursus id turpis integer aliquet massa id lobortis convallis tortor risus",
      categories: [1],
      quantity: 76,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://5.imimg.com/data5/CY/KR/MY-42394932/burger-buns-500x500.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "1b5d8aeb-9dab-41d6-91c6-b2f8cdbd973a",
      name: "Potatoes - Yukon Gold, 80 Ct",
      type: "simple",
      cost: "12",
      price: "37",
      description:
          "Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.",
      shortDescription:
          "gravida nisi at nibh in hac habitasse platea dictumst aliquam augue",
      categories: [1],
      quantity: 31,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://assets.bonappetit.com/photos/57e3fa0a4caff61056fa8789/master/pass/ttar_yukongoldpotato_v.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "7fa9a176-2aed-4274-91ee-3f8aa37e8958",
      name: "Goldschalger",
      type: "simple",
      cost: "12",
      price: "21",
      description:
          "Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.",
      shortDescription:
          "proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum",
      categories: [1],
      quantity: 55,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://dydza6t6xitx6.cloudfront.net/ci-goldschlager-cinnamon-liqueur-b646b00222f1565b.jpeg",
    ),
    Item(
      id: "9502f6c1-d1d1-41eb-9a01-5eafcce48def",
      name: "Beans - Fava, Canned",
      type: "simple",
      cost: "18",
      price: "46",
      description:
          "Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.",
      shortDescription:
          "ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem",
      categories: [1],
      quantity: 79,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/717d2FnhdNL._SL1374_.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "894f091d-536d-4b54-83a9-b1f7620b2548",
      name: "Flour Pastry Super Fine",
      type: "simple",
      cost: "15",
      price: "47",
      description:
          "Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.",
      shortDescription:
          "at dolor quis odio consequat varius integer ac leo pellentesque ultrices",
      categories: [1],
      quantity: 93,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://target.scene7.com/is/image/Target/GUEST_12820de3-24e3-4822-abf4-d823084d5c26?wid=488&hei=488&fmt=pjpeg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "19e9cc7c-ef00-4d6c-81f8-fb2117d1ee5f",
      name: "Flour - Masa De Harina Mexican",
      type: "simple",
      cost: "18",
      price: "46",
      description:
          "Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.",
      shortDescription:
          "quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis",
      categories: [1],
      quantity: 64,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://www.mexicanplease.com/wp-content/uploads/2016/03/homemade-corn-tortillas-maseca-flour.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "5dc721b4-43d6-4052-b474-26291fd2d235",
      name: "Milk - 2%",
      type: "simple",
      cost: "17",
      price: "50",
      description:
          "Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.",
      shortDescription:
          "elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla",
      categories: [1],
      quantity: 99,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://www.consumerfreedom.com/app/uploads/2019/07/Almonds-1024x952.png",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "8691531e-4d03-4bca-b5eb-ead73b87ab4e",
      name: "Bread - Flat Bread",
      type: "simple",
      cost: "10",
      price: "43",
      description:
          "Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      shortDescription:
          "magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget",
      categories: [1],
      quantity: 79,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://thecafesucrefarine.com/wp-content/uploads/Greek-Yogurt-Turkish-Flatbread-Bazlama.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "f19cc903-e215-4087-b1c0-792795aaee69",
      name: "Wine - Rosso Toscano Igt",
      type: "simple",
      cost: "17",
      price: "31",
      description:
          "Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.",
      shortDescription:
          "nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt",
      categories: [1],
      quantity: 29,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://assets.bonappetit.com/photos/5c8940dc92041125f06c3b63/16:9/w_2560%2Cc_limit/Basically-Red-Wine-02.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
    Item(
      id: "6776e75c-2d3f-40bf-a87f-199809c0657f",
      name: "Appetizer - Southwestern",
      type: "simple",
      cost: "15",
      price: "21",
      description:
          "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.",
      shortDescription:
          "consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut",
      categories: [1],
      quantity: 41,
      stockStatus: "instock",
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl:
          "https://images.food52.com/ZfRGQGHL02C8t3hIyBrvR-qaBUw=/1200x900/54a9bb89-dd79-432b-892f-576977829012--mini_spaghetti_and_meatball_appetizer-All_that-s_Jas.jpg",
      unitType: 'pc',
      preferredSupplier: "Amazon",
      size: "12m",
      comments: "Buy now!",
    ),
  ];

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addItem(Item item) async {
    var newStockStatus;

    if (item.quantity == 0) {
      newStockStatus = 'instock';
    } else {
      newStockStatus = 'instock';
    }

    final newItem = Item(
      id: DateTime.now().toString(),
      name: item.name,
      type: item.type,
      cost: item.cost,
      price: item.price,
      description: item.description,
      shortDescription: item.shortDescription,
      categories: item.categories,
      quantity: item.quantity,
      stockStatus: newStockStatus,
      dateCreated: DateTime.now(),
      dateModified: DateTime.now(),
      imageUrl: item.imageUrl,
    );

    _items.add(newItem);
    notifyListeners();
  }

  Future<void> updateItem(String id, Item newItem) async {
    final itemIndex = _items.indexWhere((item) => item.id == id);

    var newStockStatus;

    if (newItem.quantity == 0) {
      newStockStatus = 'outofstock';
    } else {
      newStockStatus = 'instock';
    }

    newItem = Item(
      id: newItem.id,
      name: newItem.name,
      quantity: newItem.quantity,
      stockStatus: newStockStatus,
      cost: newItem.cost,
      price: newItem.price,
      type: newItem.type,
      description: newItem.description,
      shortDescription: newItem.shortDescription,
      categories: newItem.categories,
      dateCreated: newItem.dateCreated,
      dateModified: DateTime.now(),
      imageUrl: newItem.imageUrl,
    );

    if (itemIndex >= 0) {
      _items[itemIndex] = newItem;
      notifyListeners();
    } 
  }

  Future<void> deleteItem(String id) async {
    final existingItemIndex = _items.indexWhere(
      (item) => item.id == id,
    );
    _items.removeAt(existingItemIndex);
    notifyListeners();
  }
}
