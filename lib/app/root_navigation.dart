import 'package:flutter/material.dart';

class RootNavigation extends InheritedWidget {
  final void Function(int) setTab;

  const RootNavigation({
    super.key,
    required this.setTab,
    required Widget child,
  }) : super(child: child);

  static RootNavigation of(BuildContext context) {
    final RootNavigation? result =
        context.dependOnInheritedWidgetOfExactType<RootNavigation>();
    assert(result != null, 'RootNavigation not found');
    return result!;
  }

  @override
  bool updateShouldNotify(RootNavigation oldWidget) =>
      setTab != oldWidget.setTab;
}
