import 'package:flutter/material.dart';
import 'package:g_in/crud.dart';
import 'package:g_in/provider/product_provider.dart';
import 'package:g_in/screen/edit_product.dart';
import 'package:g_in/home.dart';
import 'package:g_in/homeemail.dart';
import 'package:g_in/hometodo.dart';
import 'package:g_in/login.dart';
import 'package:g_in/loginfb.dart';
import 'package:g_in/loginph.dart';
import 'package:g_in/screen/product.dart';
import 'package:g_in/services/firestore_service.dart';
import 'package:g_in/uidesign.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final fireStoreService = FireStoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        StreamProvider(
          create: (context) => fireStoreService.getProducts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'product',
        routes: {
          'start': (context) => MyApp(),
          'login': (context) => LoginPage(),
          'home': (context) => HomeScreen(),
          'loginphone': (context) => LoginPhone(),
          'loginfb': (context) => LoginFb(),
          'uidesign': (context) => UiDesign(),
          'homeemail': (context) => HomeEmailScreen(),
          'hometodo': (context) => HomeTodo(),
          'crud': (context) => CrudPage(),
          'editproduct': (context) => EditProducts(),
          'product': (context) => Products(),
        },
      ),
    );
  }
}
