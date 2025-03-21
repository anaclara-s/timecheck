import 'package:flutter/material.dart';

import 'widget/clock_widget.dart';
import 'widget/greeting_widget.dart';
import '../shared/widgets/custom_appbar.dart';
import '../shared/widgets/custom_bottom_navigator_bar.dart';
import '../shared/widgets/custom_text_button.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(),
        body: Column(
          children: [
            GreetingWidget(userName: userName),
            ClockWidget(),
            CustomTextButtonWidget(onPressed: () {}, text: 'Marcar ponto'),
            Text('Últimas marcações'),
            Text('Horarios das ultimas marcações'),
            CustomBottomNavigatorBarWidget(),
          ],
        ));
  }
}
