import 'package:flutter/material.dart';
import 'package:fudee/data/api/api_service.dart';
import 'package:fudee/provider/restaurant_provider.dart';
import 'package:fudee/ui/resto_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Jakarta',
        ),
        home: const Scaffold(
          body: RestoListScreen(),
        ),
      ),
    );
  }
}
