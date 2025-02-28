import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        height: 200,
        color: Colors.deepOrangeAccent,
        child: Text('HOME PAGE'),
      ),
    );
  }
}
