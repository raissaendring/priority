import 'package:flutter/material.dart';
import 'package:priority/alerts_view_model.dart';
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
        create: (_) => AlertsViewModel(),
        child: Consumer<AlertsViewModel>(builder: (context, viewModel, _) {
          return AlertMessenger(
            child: Scaffold(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AlertButton(
                                  color: Colors.red,
                                  icon: Icons.error,
                                  text: 'Error',
                                  onPressed: () {
                                    viewModel.showAlert(
                                      alert: const Alert(
                                        backgroundColor: Colors.red,
                                        leading: Icon(Icons.error),
                                        priority: AlertPriority.error,
                                        message:
                                            'Oops, ocorreu um erro. Pedimos desculpas.',
                                      ),
                                    );
                                  },
                                ),
                                AlertButton(
                                  color: Colors.amber,
                                  icon: Icons.warning_outlined,
                                  text: 'Warning',
                                  onPressed: () {
                                    viewModel.showAlert(
                                      alert: const Alert(
                                        backgroundColor: Colors.amber,
                                        leading: Icon(Icons.warning),
                                        priority: AlertPriority.warning,
                                        message: 'Atenção! Você foi avisado.',
                                      ),
                                    );
                                  },
                                ),
                                AlertButton(
                                  color: Colors.lightGreen,
                                  icon: Icons.info_outline,
                                  text: 'Info',
                                  onPressed: () {
                                    viewModel.showAlert(
                                      alert: const Alert(
                                        backgroundColor: Colors.green,
                                        leading: Icon(Icons.info),
                                        priority: AlertPriority.info,
                                        message:
                                            'Este é um aplicativo escrito em Flutter.',
                                      ),
                                    );
                                  },
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
            ),
          );
        }),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const AlertButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          const SizedBox(width: 4.0),
          Text(text),
        ],
      ),
    );
  }
}
