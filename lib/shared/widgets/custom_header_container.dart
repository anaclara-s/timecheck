import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomHeaderContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRaius;

  const CustomHeaderContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.borderRaius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDarkMode ? kDarkHeaderContainerColor : kLightHeaderContainerColor,
        borderRadius: borderRaius ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(190),
              bottomRight: Radius.circular(190),
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
