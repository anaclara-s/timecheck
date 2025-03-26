import 'package:flutter/material.dart';

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
        text: 'Time Clock',
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 80, 184, 216),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
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
          Text('Últimas marcações'),
          Expanded(
            child: ListView.builder(
              itemCount: state.recentRecords.length,
              itemBuilder: (context, index) {
                final record = state.recentRecords[index];
                return ListTile(
                  title: Text('${record.date} - ${record.time}'),
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
