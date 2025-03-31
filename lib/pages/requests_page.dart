import 'package:flutter/material.dart';

import '../core/widgets/custom_appbar.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(text: 'Solicitações de mudanças'),
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
