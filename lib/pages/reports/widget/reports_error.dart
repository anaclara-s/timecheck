import 'package:flutter/material.dart';

class ReportsErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ReportsErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Erro ao carregar relatórios',
              style: TextStyle(color: Colors.red)),
          Text(errorMessage, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
