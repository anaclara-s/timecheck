import 'package:flutter/material.dart';

import '../core/widgets/custom_appbar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(text: 'Relatorios de ponto'),
      body: Column(
        children: [
          Text(
            'data',
          ),
        ],
      ),
    );
  }
}
