import 'package:flutter/material.dart';

import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_elevated_button.dart';
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
      appBar: const CustomAppbarWidget(
        text: 'Time Clock',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 80, 184, 216),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                        bottomRight: Radius.circular(200),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        GreetingWidget(userName: state.widget.userName),
                        const SizedBox(height: 30),
                        const ClockWidget(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomElevatedButtonWidget(
                      key: ValueKey(state.nextRecordType),
                      onPressed: state.recordTime,
                      text: state.buttonText,
                      isLoading: state.isLoading,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Últimas marcações',
                      style: TextStyle(fontSize: 18),
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
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
