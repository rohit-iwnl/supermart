import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/model/DatabaseManager.dart';
import 'package:groceryapp/pages/cart_page_payment.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scanResult = "Qr code result";
  var add = "";
  List productsListMain = [];
  List productsListid = [];
  List productsListname = [];
  List productsListprice = [];
  List productsListweight = [];
  List cartBarcodes = [];
  List adding = [];
  bool _isInitialised = false;
  List extra = [];
  var count = 0;

  void addDetails(String id, int price, int weight, String name) {
    productsListid.add(id);
    productsListname.add(price);
    productsListprice.add(weight);
    productsListweight.add(name);
  }

  void _scanVision() async {
    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        waitTap: true,
        showText: true,
        fps: 20,
      );
      if (barcodes.length > 0) {
        for (Barcode barcode in barcodes) {
          print(
              "barcodeValues ${barcode.displayValue} ${barcode.getFormatString()} ${barcode.getValueFormatString()}");
          cartBarcodes.add((barcode.displayValue).toString());
        }
        for (var i = 1; i < productsListid.length; i++) {
          var current = productsListid[i];
          if (cartBarcodes[count] == current) {
            adding.add(productsListname[i]);
            adding.add(productsListprice[i]);
            adding.add("lib/images/biscuit.png");
            adding.add("MaterialColor(primary value: Color(0xff4caf50))");
            adding.add(productsListweight[i]);
            add =
                "[ ${productsListname[i].toString()}, ${productsListprice[i]}, lib/images/biscuit.png, MaterialColor(primary value: Color(0xff4caf50)), ${productsListweight[i]}]";
            print(adding);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((x) => setState(() {
          _isInitialised = true;
        }));
    fetchDatabaseid();
    fetchDatabasename();
    fetchDatabaseprice();
    fetchDatabaseweight();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getProductsList();
    if (resultant == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        productsListMain = resultant;
      });
    }
    print(productsListid);
  }

  fetchDatabaseid() async {
    dynamic resultant = await DatabaseManager().getProductsid();
    if (resultant == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        productsListid = resultant;
      });
    }
    print(productsListid);
  }

  fetchDatabasename() async {
    dynamic resultant = await DatabaseManager().getProductsname();
    if (resultant == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        productsListname = resultant;
      });
    }
    print(productsListname);
  }

  fetchDatabaseprice() async {
    dynamic resultant = await DatabaseManager().getProductsprice();
    if (resultant == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        productsListprice = resultant;
      });
    }
    print(productsListprice);
  }

  fetchDatabaseweight() async {
    dynamic resultant = await DatabaseManager().getProductsweight();
    if (resultant == null) {
      print("Unable to fetch data");
    } else {
      setState(() {
        productsListweight = resultant;
      });
    }
    print(productsListweight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Icon(
            Icons.location_on,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          'Bangalore',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                splashColor: Colors.green,
                onTap: _scanVision,
                child: const Icon(Icons.camera_alt_outlined),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPayment();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 40),
                child: InkWell(
                  splashColor: Colors.green,
                  onTap: () {
                    count = count + 1;
                    Provider.of<CartModel>(context, listen: false)
                        .addItemToCartBarcodes(adding);
                  },
                  child: const Icon(Icons.task_alt_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Good afternoon,'),
          ),

          const SizedBox(height: 4),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order items for you",
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Popular Items",
              style: GoogleFonts.notoSerif(
                //fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // recent orders -> show last 3h
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: value.shopItems[index][0],
                      itemPrice: value.shopItems[index][1],
                      imagePath: value.shopItems[index][2],
                      color: value.shopItems[index][3],
                      onPressed: () =>
                          Provider.of<CartModel>(context, listen: false)
                              .addItemToCart(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void scanBarcode() async {
    print("opening");
    String scan;
    try {
      scan = await FlutterBarcodeScanner.scanBarcode(
          '#ff66666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      scan = "Failed to scan barcode";
    }
    if (!mounted) return;
    setState(() {
      scanResult = scan;
    });
    print(scan);
  }
}
