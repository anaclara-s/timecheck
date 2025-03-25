import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  const CustomAppbarWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColorAppBar,
      title: Text(
        text,
        style: TextStyle(
          color: kLigthTextColors,
          fontSize: kSizeTexts,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
