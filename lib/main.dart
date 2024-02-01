import 'package:flutter/material.dart';
import 'package:priority/view_model.dart';
import 'package:provider/provider.dart';

import 'alert_messenger.dart';

void main() => runApp(const AlertPriorityApp());

class AlertPriorityApp extends StatelessWidget {
  const AlertPriorityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priority',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(size: 16.0, color: Colors.white),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(110, 40)),
          ),
        ),
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => ViewModel(),
        child: Consumer<ViewModel>(builder:
            (BuildContext context, ViewModel viewModel, Widget? child) {
          return AlertMessenger(
            child: Builder(
              builder: (_) {
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: AppBar(
                    title: const Text('Alerts'),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              viewModel.currentMessage(),
                              // AlertMessenger.of(context).currentMessage(),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.showAlert(
                                          // AlertMessenger.of(context).showAlert(
                                          alert: const Alert(
                                            backgroundColor: Colors.red,
                                            leading: Icon(Icons.error),
                                            priority: AlertPriority.error,
                                            message:
                                                'Oops, ocorreu um erro. Pedimos desculpas.',
                                          ),
                                        );
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.error),
                                          SizedBox(width: 4.0),
                                          Text('Error'),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.showAlert(
                                          // AlertMessenger.of(context).showAlert(
                                          alert: const Alert(
                                            backgroundColor: Colors.amber,
                                            leading: Icon(Icons.warning),
                                            priority: AlertPriority.warning,
                                            message:
                                                'Atenção! Você foi avisado.',
                                          ),
                                        );
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.amber),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.warning_outlined),
                                          SizedBox(width: 4.0),
                                          Text('Warning'),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.showAlert(
                                          // AlertMessenger.of(context).showAlert(
                                          alert: const Alert(
                                            backgroundColor: Colors.green,
                                            leading: Icon(Icons.info),
                                            priority: AlertPriority.info,
                                            message:
                                                'Este é um aplicativo escrito em Flutter.',
                                          ),
                                        );
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.lightGreen),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.info_outline),
                                          SizedBox(width: 4.0),
                                          Text('Info'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 16.0,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: viewModel.hideAlert,
                                    // AlertMessenger.of(context).hideAlert,
                                    child: const Text('Hide alert'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
