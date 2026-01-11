import 'package:flutter/material.dart';

final appRefreshNotifier = ValueNotifier<int>(0);

void notifyAppRefresh() {
  appRefreshNotifier.value++;
}
