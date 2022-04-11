import 'package:flutter/material.dart';
import 'widgets/bottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(child: Container(child: Text('Navbar'))),
        bottomNavigationBar: Navbar(),
      ),
    );
  }
}
