import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference productsList =
      FirebaseFirestore.instance.collection('productsInfo');

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
}
