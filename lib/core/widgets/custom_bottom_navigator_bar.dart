import 'package:flutter/material.dart';

class CustomBottomNavigatorBarWidget extends StatelessWidget {
  const CustomBottomNavigatorBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromARGB(221, 163, 110, 110),
      unselectedItemColor: Colors.deepPurple,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.waving_hand_rounded), label: 'Solicitações'),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Mais informações'),
        BottomNavigationBarItem(
            icon: Icon(Icons.move_to_inbox_sharp), label: 'Relatórios'),
      ],
    );
  }
}
