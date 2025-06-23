import 'package:flutter/material.dart';
import 'package:studentregister/page/homes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 15, 148)),
      ),
      home: const HomePage(),
    );
  }
}

