import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceryapp/pages/home_page.dart';

class DatabaseManager {
  final CollectionReference productsList =
      FirebaseFirestore.instance.collection('productsInfo');
  final HomePage hp = new HomePage();

  List extras = [];

  Future getProductsList() async {
    List itemsList = [];
    try {
      await productsList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
          print(element.data());
        });
      });
      print("Done successfully");
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsid() async {
    List itemsid1 = [];
    try {
      await productsList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsid1.add(element.get("id"));
        });
      });
      print("Done successfully");
      return itemsid1;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsname() async {
    List itemsname = [];
    try {
      await productsList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsname.add(element.get("name"));
        });
      });
      print("Done successfully");
      return itemsname;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsprice() async {
    List itemsprice = [];
    try {
      await productsList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsprice.add(element.get("price"));
        });
      });
      print("Done successfully");
      return itemsprice;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsweight() async {
    List itemsweight = [];
    try {
      await productsList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsweight.add(element.get("weight"));
        });
      });
      print("Done successfully");
      return itemsweight;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void additems(String add) {
    extras.add(add);
  }

  List addextras() {
    return extras;
  }
}
