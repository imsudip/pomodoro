import 'package:get/get.dart';

class TimeSettings extends GetxController {
  var pomodoro = 25.obs;
  var shortBreak = 5.obs;
  var longBreak = 15.obs;
  setPomodoro(var a) {
    pomodoro.value = a;
  }

  setShort(var a) {
    shortBreak.value = a;
  }

  setLong(var a) {
    longBreak.value = a;
  }
}
