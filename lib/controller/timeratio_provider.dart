import 'package:flutter/foundation.dart';

import '../custom_widgets/time_ratio.dart';

class TimeRatioProvider extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  static final List buttons = [
    "All",
    "Today",
    "Tomorrow",
    "Past",
  ];
  List<TimeRatio> timeRatioButtons = [];

  void fillTimeRatioArray() {
    if (timeRatioButtons.isEmpty) {
      for (int i = 0; i < 4; i++) {
        timeRatioButtons.add(TimeRatio(text: buttons[i], isSelect: false));
      }
      timeRatioButtons[0].isSelect = true;
    }
  }

  void changeTimeRatio(int index) {
    timeRatioButtons[index].isSelect = true;
    print(index);
    for (int i = 0; i < timeRatioButtons.length; i++) {
      if (timeRatioButtons[i].isSelect && i != index) {
        timeRatioButtons[i].isSelect = false;
      }
    }

    notifyListeners();
  }
}
