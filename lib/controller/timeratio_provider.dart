import 'package:flutter/foundation.dart';

import '../custom_widgets/time_ratio.dart';

class TimeRatioProvider extends ChangeNotifier {

  static final List timesText = ["All", "Today", "Tomorrow", "Past"];

  List<TimeRatio> timeRatioButtons = [];

  void fillTimeRatioArray() {
    if (timeRatioButtons.isEmpty) {
      timeRatioButtons =
          timesText
              .map((e) => TimeRatio(text: e, isSelect: false))
              .toList();
    }
    timeRatioButtons.elementAt(0).isSelect = true;
    notifyListeners();
  }

  void changeTimeRatio(int index) {
    timeRatioButtons[index].isSelect = true;
    for (var element in timeRatioButtons) {
      if (element.isSelect && element != timeRatioButtons[index]) {
        element.isSelect = false;
      }
    }
    if (kDebugMode) print(timeRatioButtons[index].text);
    notifyListeners();
  }
}
