import 'package:flutter/material.dart';

import '../shared/widgets/custom_appbar.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight,
              ),
              child: Column(
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
                        SizedBox(height: 20),
                        ClockWidget(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextButtonWidget(
                      key: ValueKey(state.nextRecordType),
                      onPressed: state.recordTime,
                      text: state.buttonText,
                      isLoading: state.isLoading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Últimas marcações',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: ListView.builder(
                      itemCount: state.lastFiveRecords.length,
                      itemBuilder: (context, index) {
                        final record = state.lastFiveRecords[index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            title: Text(
                                '${record.time} - ${record.formattedDate}'),
                            subtitle:
                                Text(state.formatRecordType(record.recordType)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
