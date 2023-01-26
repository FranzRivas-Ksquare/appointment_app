import 'package:flutter/foundation.dart';
import '../custom_widgets/time_ratio.dart';

class TimeRatioBarService extends ChangeNotifier {

  static final List timesText = ["Active", "Today", "Tomorrow", "Past"];
  int _index = 0;
  int get index => _index;

  List<TimeRatio> _timeRatioButtons = [];

  List<TimeRatio> get timeRatioButtons => _timeRatioButtons;

  void fillTimeRatioArray() {
    if (_timeRatioButtons.isEmpty) {
      _timeRatioButtons =
          timesText
              .map((e) => TimeRatio(myIndex: timesText.indexOf(e), text: e))
              .toList();
    }
    notifyListeners();
  }

  void changeTimeRatio(int index) {
    _index = index;
    notifyListeners();
  }

}
