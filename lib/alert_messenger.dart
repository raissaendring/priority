import 'package:flutter/material.dart';
import 'package:priority/view_model.dart';
import 'package:provider/provider.dart';

const kAlertHeight = 80.0;

enum AlertPriority {
  error(2),
  warning(1),
  info(0);

  const AlertPriority(this.value);
  final int value;
}

class Alert extends StatelessWidget implements Comparable {
  const Alert({
    super.key,
    required this.backgroundColor,
    required this.message,
    required this.leading,
    required this.priority,
  });

  final Color backgroundColor;

  final String message;
  final Widget leading;
  final AlertPriority priority;

  @override
  Widget build(BuildContext context) {
    final statusbarHeight = MediaQuery.of(context).padding.top;
    return Material(
      child: Ink(
        color: backgroundColor,
        height: kAlertHeight + statusbarHeight,
        child: Column(
          children: [
            SizedBox(height: statusbarHeight),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 28.0),
                  IconTheme(
                    data: const IconThemeData(
                      color: Colors.white,
                      size: 36,
                    ),
                    child: leading,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.white),
                      child: Text(message),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 28.0),
          ],
        ),
      ),
    );
  }

  @override
  int compareTo(other) {
    if (other is Alert) {
      return priority.value.compareTo(other.priority.value);
    }
    return -1;
  }
}

class AlertMessenger extends StatefulWidget {
  const AlertMessenger({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AlertMessenger> createState() => AlertMessengerState();
}

class AlertMessengerState extends State<AlertMessenger>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final alertHeight = MediaQuery.of(context).padding.top + kAlertHeight;
    animation = Tween<double>(begin: -alertHeight, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    context.watch<ViewModel>().controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(
      builder: (context, viewModel, _) {
        final listAlertWidgets = viewModel.listAlertWidgets;
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Stack(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Positioned.fill(
                  top: _calculateChildPosition(listAlertWidgets),
                  child: widget.child,
                ),
                if (listAlertWidgets.isNotEmpty)
                  ...listAlertWidgets.take(listAlertWidgets.length - 1),
                Positioned(
                  top: animation.value,
                  left: 0,
                  right: 0,
                  child: listAlertWidgets.lastOrNull ?? const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double _calculateChildPosition(List<Alert> listAlertWidgets) {
    final statusbarHeight = MediaQuery.of(context).padding.top;
    var maxPosition = kAlertHeight - statusbarHeight;

    if (listAlertWidgets.isEmpty) {
      return 0;
    } else if (listAlertWidgets.length > 1) {
      return maxPosition;
    } else {
      final animationPosition = animation.value + kAlertHeight;
      return animationPosition <= statusbarHeight
          ? 0.0
          : animationPosition - statusbarHeight;
    }
  }
}
