import 'package:flutter/material.dart';
import 'package:priority/alert_messenger.dart';

class AlertsViewModel extends ChangeNotifier {
  final List<Alert> _listAlertWidgets = List.empty(growable: true);
  AnimationController? _controller;

  List<Alert> get listAlertWidgets => _listAlertWidgets;

  void setController(AnimationController controller) {
    _controller = controller;
  }

  void showAlert({required Alert alert}) {
    if (!_listAlertWidgets.any((e) => e.priority == alert.priority)) {
      _listAlertWidgets.add(alert);
      _listAlertWidgets.sort();

      notifyListeners();
    }

    bool addedToLastPosition = _listAlertWidgets.lastOrNull == alert;
    if (addedToLastPosition) {
      _controller?.reset();
      _controller?.forward();
    }
  }

  void hideAlert() {
    _controller?.reverse().then((value) {
      if (_listAlertWidgets.isNotEmpty) _listAlertWidgets.removeLast();
      notifyListeners();

      _controller?.value = _controller?.upperBound ?? 0;
    });
  }

  String currentMessage() {
    return _listAlertWidgets.lastOrNull?.message ?? '';
  }
}
