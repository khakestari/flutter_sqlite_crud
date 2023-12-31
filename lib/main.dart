import 'package:flutter/material.dart';

import './model/product.dart';
import './database/dbhandler.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Local Database',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF0277BD),
          onPrimary: Color.fromARGB(255, 255, 255, 255),
          secondary: Color.fromARGB(255, 142, 228, 29),
          onSecondary: Color.fromARGB(255, 98, 188, 20),
          error: Color.fromARGB(255, 219, 86, 86),
          onError: Color.fromARGB(255, 192, 19, 19),
          background: Color(0xFF0277BD),
          onBackground: Color.fromARGB(255, 223, 243, 255),
          surface: Color(0xFF0277BD),
          onSurface: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? name, description;
  double? price;

  getName(name) {
    this.name = name;
  }

  getDescription(description) {
    this.description = description;
  }

  getPrice(price) {
    this.price = double.parse(price);
  }

  createData(product) {
    setState(() {
      var dbHandler = DBHandler();
      dbHandler.createP(product);
    });
  }

  readData(String name) {
    setState(() {
      var dbHandler = DBHandler();
      Future<Product> product = dbHandler.readP(name);
      product.then((value) {
        print(value.name);
        print(value.description);
        print(value.price);
      });
    });
  }

  updateData(product) {
    setState(() {
      var dbHandler = DBHandler();
      dbHandler.updateP(product);
    });
  }

  deleteData(String name) {
    setState(() {
      var dbHandler = DBHandler();
      dbHandler.deleteP(name);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase CRUD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (String name) {
                getName(name);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              onChanged: (String description) {
                getDescription(description);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Price',
              ),
              onChanged: (String price) {
                getPrice(price);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.ltr,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(80, 50),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    createData(Product(name!, description!, price!));
                  },
                  child: const Text('Create'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(80, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    readData(name!);
                  },
                  child: const Text('Read'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(80, 50),
                    backgroundColor: Colors.orange[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    updateData(Product(name!, description!, price!));
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(80, 50),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    deleteData(name!);
                  },
                  child: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
