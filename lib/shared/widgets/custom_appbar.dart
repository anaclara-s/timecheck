import 'package:flutter/material.dart';
import 'package:timecheck/shared/constants.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColorAppBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
