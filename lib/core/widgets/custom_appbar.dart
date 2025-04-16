import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;

  const CustomAppbarWidget({
    super.key,
    required this.text,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColorAppBar,
      title: Text(
        text,
        style: const TextStyle(
          color: kLigthTextColors,
          fontSize: kSizeTexts,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
