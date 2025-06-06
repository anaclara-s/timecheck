import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../reports/reports_page.dart';

class NavigationBarPage extends StatefulWidget {
  final String userName;
  final int employeeId;

  const NavigationBarPage({
    super.key,
    required this.userName,
    required this.employeeId,
  });

  @override
  State<NavigationBarPage> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigationBarPage> {
  int currentPageIndex = 1;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ReportsPage(employeeId: widget.employeeId),
      HomePage(
        userName: widget.userName,
        employeeId: widget.employeeId,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined), label: 'Relatório'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Início'),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 60, 150, 177),
        backgroundColor: const Color.fromARGB(255, 13, 38, 150),
      ),
    );
  }
}
