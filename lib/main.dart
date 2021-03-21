import 'package:flutter/material.dart';
import 'package:memby/screens/homeScreen.dart';

void main() => runApp(MembyApp());

class MembyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
