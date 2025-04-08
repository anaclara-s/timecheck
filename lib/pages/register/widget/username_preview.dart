import 'package:flutter/material.dart';

class UsernamePreview extends StatelessWidget {
  final String username;

  const UsernamePreview({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    if (username.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seu nome de usuário será:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 27, 63, 131),
            borderRadius: BorderRadius.circular(12),
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
