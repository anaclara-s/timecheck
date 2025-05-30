import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm:ss').format(now);
          final formatterDate = DateFormat('dd/MM/yyyy').format(now);

          return Column(
            children: [
              Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatterDate,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        });
  }
}
