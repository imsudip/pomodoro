import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/controller.dart';
import 'package:pomodoro/settingsPage.dart';
import 'package:pomodoro/styles.dart';
import 'package:pomodoro/timerCircle.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeColor themeColor = Get.put(ThemeColor());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: blueDark,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                25.heightBox,
                Center(
                  child: Text(
                    "pomodoro",
                    style: header,
                  ),
                ),
                40.heightBox,
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(32)),
                  child: TabBar(
                      isScrollable: true,
                      indicator: ContainerTabIndicator(
                        color: themeColor.main.value,
                        radius: BorderRadius.circular(30),
                        heightFraction: 0.85,
                      ),
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelColor: black,
                      unselectedLabelColor: white.withOpacity(0.6),
                      labelStyle: tabLabel,
                      tabs: [
                        Tab(
                          text: 'pomodoro',
                        ),
                        Tab(
                          text: 'short break',
                        ),
                        Tab(
                          text: 'long break',
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      TimerCircle(
                        timerType: TimerType.pomodaro,
                      ),
                      TimerCircle(
                        timerType: TimerType.short,
                      ),
                      TimerCircle(
                        timerType: TimerType.long,
                      ),
                    ],
                  ),
                ),
                InkWell(
                    child: Icon(
                      Icons.settings,
                      color: white.withOpacity(0.6),
                      size: 30,
                    ).p4().circle(
                        radius: 50, backgroundColor: white.withOpacity(0.2)),
                    onTap: () {
                      Get.dialog(SettingsPage());
                    }),
                25.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
