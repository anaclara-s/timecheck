import 'package:flutter/material.dart';
import 'package:timecheck/shared/widgets/custom_bottom_navigator_bar.dart';
import 'package:timecheck/shared/widgets/custom_text_button.dart';

import '../shared/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(),
        body: Column(
          children: [
            Text('Bom dia/Boa tarde/Boa noite'),
            Text('Nome do usuário'),
            Text('relogio'),
            Text('data'),
            CustomTextButtonWidget(onPressed: () {}, text: 'Marcar ponto'),
            Text('Últimas marcações'),
            Text('Horarios das ultimas marcações'),
            CustomBottomNavigatorBarWidget(),
          ],
        ));
  }
}
