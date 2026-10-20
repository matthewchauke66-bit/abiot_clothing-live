import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

void main() => runApp(AbiotApp());

class AbiotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cart = [];
  final String abiotNumber = "263786078446";

  final List products = [
    {"name": "Abiot Orange Satin Gown", "price": 55, "image": "assets/images/dress1.jpg"},
    {"name": "Abiot Pink Bow Dress", "price": 70, "image": "assets/images/dress2.jpg"},
    {"name": "Abiot Burgundy Blazer Dress", "price": 65, "image": "assets/images/dress3.jpg"},
    {"name": "Abiot Pink Drape Dress", "price": 60, "image": "assets/images/dress4.jpg"},
    {"name": "Abiot Red Glitter Gala Gown", "price": 90, "image": "assets/images/dress5.jpg"},
    {"name": "Abiot Champagne Balloon Dress", "price": 35, "image": "assets/images/dress6.jpg"},
  ];

  void orderOnWhatsApp() {
    String items = cart.map((e) => "- ${e['name']} (\$${e['price']})").join("%0A");
    int total = cart.fold(0, (a,b) => a + b["price"] as int);
    String msg = "Hi%20Abiot%20Clothing%20%F0%9F%94%A5%0AI%20want%20to%20order:%0A$items%0A%0ATOTAL:%20%24$total";
    String url = "https://wa.me/$abiotNumber?text=$msg";
    if(kIsWeb) html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    int total = cart.fold(0, (a,b) => a + b["price"] as int);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("ABIOT CLOTHING", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2)),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(12), child: Text("NEW DROP - 6 ITEMS", style: TextStyle(fontWeight: FontWeight.w900))),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.52, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: products.length,
              itemBuilder: (c,i){
                var p = products[i];
                return Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(16)), child: Image.asset(p["image"] as String, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c,e,s) => Icon(Icons.image)))),
                      Padding(padding: EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p["name"] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11), maxLines: 2),
                        Text("\$${p["price"]}", style: TextStyle(fontWeight: FontWeight.w800)),
                        SizedBox(height: 6),
                        SizedBox(width: double.infinity, height: 30, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white), onPressed: (){ setState(()=>cart.add(p)); }, child: Text("Add", style: TextStyle(fontSize: 11)))),
                      ])),
                    ],
                  ),
                );
              },
            ),
          ),
          if(cart.isNotEmpty) InkWell(onTap: orderOnWhatsApp, child: Container(width: double.infinity, color: Colors.black, padding: EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.chat, color: Color(0xFF25D366), size: 18), SizedBox(width: 8), Text("ORDER ON WHATSAPP • \$$total", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900))]))),
        ],
      ),
    );
  }
}