/*
* ========== Ostad Flutter Batch-10 Assignment ==========
* Assignment-03
* Name: Mohammad Monir Hossain
* Email: monir.nub.cse996@gmail.com
* Phone: 01521439480
* */


import 'package:flutter/material.dart';
import '../pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment-03',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}