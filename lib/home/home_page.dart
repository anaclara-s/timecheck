import 'package:flutter/material.dart';
import 'package:timecheck/shared/widgets/custom_header_container.dart';

import '../shared/widgets/custom_appbar.dart';
import '../shared/widgets/custom_bottom_navigator_bar.dart';
import '../shared/widgets/custom_text_button.dart';
import 'controller/home_controller.dart';
import 'widget/clock_widget.dart';
import 'widget/greeting_widget.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final int employeeId;

  const HomePage({
    super.key,
    required this.userName,
    required this.employeeId,
  });

  @override
  State<HomePage> createState() => HomeController();
}

class HomePageView extends StatelessWidget {
  final HomeController state;

  const HomePageView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        text: 'Marcações de ponto',
      ),
      body: Column(
        children: [
          CustomHeaderContainerWidget(
            child: Column(
              children: [
                GreetingWidget(userName: state.widget.userName),
                SizedBox(height: 50),
                ClockWidget(),
              ],
            ),
          ),
          CustomTextButtonWidget(
            key: ValueKey(state.nextRecordType),
            onPressed: state.recordTime,
            text: state.buttonText,
            isLoading: state.isLoading,
          ),
          SizedBox(height: 40),
          Text('Últimas marcações'),
          Expanded(
            child: ListView.builder(
              itemCount: state.lastFiveRecords.length,
              itemBuilder: (context, index) {
                final record = state.lastFiveRecords[index];
                return ListTile(
                  title: Text('${record.time} - ${record.formattedDate}'),
                  subtitle: Text(state.formatRecordType(record.recordType)),
                );
              },
            ),
          ),
          CustomBottomNavigatorBarWidget(),
        ],
      ),
    );
  }
}
