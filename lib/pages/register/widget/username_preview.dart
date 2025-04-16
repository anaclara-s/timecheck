import 'package:flutter/material.dart';

class UsernamePreviewWidget extends StatelessWidget {
  final String username;

  const UsernamePreviewWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    if (username.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const Text(
          'Seu usuário será:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade700),
          ),
          child: Text(
            username,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
