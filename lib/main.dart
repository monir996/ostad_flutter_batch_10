/*
* ========== Ostad Flutter Batch-10 Assignment ==========
* Assignment-02
* Name: Mohammad Monir Hossain
* Email: ahmedmonir303@gmail.com
* Phone: 01521439480
* */

import 'package:flutter/material.dart';
import 'Home.dart';

main(){
  runApp(ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false);
  }
}




