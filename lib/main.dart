import 'package:flutter/material.dart';
import 'package:fudee/resto_detail_screen.dart';
import 'package:fudee/resto_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Jakarta',
      ),
      home: const Scaffold(
        body: RestoListScreen(),
      ),
    );
  }
}
