class PomoMethods {
  List<String> timefromSec(int secn) {
    List<String> time = ["0", "0"];
    String min = ((secn ~/ 60)).toString();
    String sec = (secn % 60).toString();
    if (int.parse(min) <= 9) {
      time[0] = "0$min";
    } else {
      time[0] = min;
    }
    if (int.parse(sec) <= 9) {
      time[1] = "0$sec";
    } else {
      time[1] = sec;
    }

    return time;
  }
}
