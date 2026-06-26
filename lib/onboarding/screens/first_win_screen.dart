import 'package:flutter/material.dart';

class FirstWinScreen extends StatelessWidget {
  const FirstWinScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('First', style: TextStyle(color: Colors.white))),
    );
  }
}