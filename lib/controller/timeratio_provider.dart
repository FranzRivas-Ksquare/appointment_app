import 'package:flutter/foundation.dart';

import '../custom_widgets/time_ratio.dart';

class TimeRatioProvider extends ChangeNotifier {

  static final List timesText = ["All", "Today", "Tomorrow", "Past"];
  int index = 0;

  List<TimeRatio> _timeRatioButtons = [];

  List<TimeRatio> get timeRatioButtons => _timeRatioButtons;

  void fillTimeRatioArray() {
    if (_timeRatioButtons.isEmpty) {
      _timeRatioButtons =
          timesText
              .map((e) => TimeRatio(text: e, isSelect: false))
              .toList();
    }
    _timeRatioButtons.elementAt(0).isSelect = true;
    notifyListeners();
  }

  void changeTimeRatio(int index) {
    for (var element in _timeRatioButtons) {
        element.isSelect = false;
    }
    this.index = index;
    _timeRatioButtons[index].isSelect = true;
    if (kDebugMode) print(_timeRatioButtons[index].text);
    notifyListeners();
  }

}
