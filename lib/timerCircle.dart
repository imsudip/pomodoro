import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/controller.dart';
import 'package:pomodoro/styles.dart';
import 'package:pomodoro/timerCircle.dart';
import 'package:velocity_x/velocity_x.dart';

enum TimerType { pomodaro, short, long }

class TimerCircle extends StatefulWidget {
  final TimerType timerType;
  TimerCircle({
    Key key,
    this.timerType,
  }) : super(key: key);

  @override
  _TimerCircleState createState() => _TimerCircleState();
}

class _TimerCircleState extends State<TimerCircle> {
  final TimeSettings timeSettings = Get.put(TimeSettings());
  final ThemeColor themeColor = Get.put(ThemeColor());
  final CustomTimerController _controller = new CustomTimerController();
  CustomTimerState timerstate = CustomTimerState.reset;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalMin = widget.timerType == TimerType.pomodaro
          ? timeSettings.pomodoro.value
          : widget.timerType == TimerType.short
              ? timeSettings.shortBreak.value
              : timeSettings.longBreak.value;

      return CustomTimer(
        controller: _controller,
        from: Duration(minutes: totalMin),
        to: Duration(minutes: 0),
        onBuildAction: CustomTimerAction.go_to_start,
        onChangeState: (state) {
          setState(() {
            timerstate = state;
          });
        },
        builder: (CustomTimerRemainingTime remaining) {
          if (timerstate == CustomTimerState.reset &&
              totalMin != int.parse(remaining.minutes)) {
            Future.delayed(Duration(milliseconds: 150), () {
              _controller.start();
              //print("rebuild");
              _controller.reset();
            });
          }
          if (Get.isDialogOpen && timerstate != CustomTimerState.reset) {
            print("dialog open");

            Future.delayed(Duration(milliseconds: 150), () {
              _controller.reset();
            });
          }
          return Container(
            height: context.width * 0.88 <= context.percentHeight * 50
                ? context.width * 0.88
                : context.percentHeight * 50,
            width: context.width * 0.88 <= context.percentHeight * 50
                ? context.width * 0.88
                : context.percentHeight * 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.8),
                      offset: Offset(20, 20),
                      spreadRadius: 20,
                      blurRadius: 30),
                  BoxShadow(
                      color: blue,
                      offset: Offset(-15, -15),
                      spreadRadius: 16,
                      blurRadius: 30)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 0.8],
                    colors: [black, blue])),
            child: CircularPercentIndicator(
              radius: (context.width * 0.88 <= context.percentHeight * 50
                      ? context.width * 0.88
                      : context.percentHeight * 50) -
                  40.0,
              lineWidth: 8,
              percent: int.parse(remaining.minutes) + 1 > totalMin
                  ? 1
                  : (int.parse(remaining.minutes) * 60 +
                          int.parse(remaining.seconds)) /
                      (totalMin * 60),
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 600,
              curve: Curves.fastOutSlowIn,
              center: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: black,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 35,
                          child: Center(
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity:
                                  timerstate == CustomTimerState.paused ? 1 : 0,
                              child: InkWell(
                                onTap: () {
                                  _controller.reset();
                                },
                                child: Icon(
                                  Icons.sync,
                                  color: white,
                                ).circle(
                                    radius: 40,
                                    backgroundColor: white.withOpacity(0.2)),
                              ),
                            ),
                          )),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 50,
                          child: Center(
                              child: Text(
                            timerstate == CustomTimerState.reset
                                ? 'S T A R T'
                                : timerstate == CustomTimerState.counting
                                    ? "P A U S E"
                                    : timerstate == CustomTimerState.paused
                                        ? "R E S U M E"
                                        : "R E S E T",
                            style: GoogleFonts.rubik(
                                letterSpacing: 3,
                                fontSize: 20,
                                color: white,
                                fontWeight: FontWeight.w400),
                          )).onTap(() {
                            timerstate == CustomTimerState.reset
                                ? _controller.start()
                                : timerstate == CustomTimerState.counting
                                    ? _controller.pause()
                                    : timerstate == CustomTimerState.paused
                                        ? _controller.start()
                                        : _controller.reset();
                          })),
                      Positioned.fill(
                          child: Center(
                              child: Text(
                        "${remaining.minutes}:${remaining.seconds}",
                        style: time,
                      )))
                    ],
                  )),
              progressColor: themeColor.main.value,
              backgroundColor: Colors.transparent,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          );
        },
        interval: Duration(seconds: 1),
      );
    });
  }
}
