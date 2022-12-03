import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "40", "lib/images/avocado.png", Colors.green,"20"],
    ["Banana", "250", "lib/images/banana.png", Colors.yellow,"10"],
    ["Chicken", "120", "lib/images/chicken.png", Colors.brown,"100"],
    ["Water", "10", "lib/images/water.png", Colors.blue,"20"],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
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
