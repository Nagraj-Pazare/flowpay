import 'package:flutter/material.dart';
import 'pages/main_screen.dart';

void main() {
  runApp(const AquaBillApp());
}

class AquaBillApp extends StatelessWidget {
  const AquaBillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaBill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
