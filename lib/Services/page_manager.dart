import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../Classes/AppAction.dart';
import '../Models/ChartData.dart';

class PageManager {
  final audioError = ValueNotifier<int>(0);
  final chartDataNotifier = ValueNotifier<List<ChartData>>([]);

  final appPageMessageNotifier = ValueNotifier<String>('');
  final appPageActionNotifier = ValueNotifier<AppAction>(AppAction.normal);

  // Events: Calls coming from the UI
  void init() async {
  }
}