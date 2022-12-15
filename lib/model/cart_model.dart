import 'package:flutter/material.dart';
import 'package:groceryapp/model/DatabaseManager.dart';
import 'package:groceryapp/pages/home_page.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "40", "lib/images/avocado.png", Colors.green, "20"],
    ["Banana", "20", "lib/images/banana.png", Colors.yellow, "10"],
    ["Chicken", "120", "lib/images/chicken.png", Colors.brown, "100"],
    ["Water", "10", "lib/images/water.png", Colors.blue, "20"],
  ];

  List _extraItems = DatabaseManager().addextras();

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;
  get extraItems => _extraItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    print(_cartItems);
    notifyListeners();
  }

  void addItemToCartBarcodes(List add) {
    _cartItems.add(add);
    print("success followed by");
    print(_cartItems);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  int calculateTotalWeight() {
    int totalWeight = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalWeight += int.parse(cartItems[i][4]);
    }
    return totalWeight;
  }

  // calculate total price
  int calculateTotal() {
    int totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += int.parse(cartItems[i][1]);
    }
    return totalPrice;
  }
}
