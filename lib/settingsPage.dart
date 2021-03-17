import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:pomodoro/controller.dart';
import 'package:pomodoro/styles.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:line_icons/line_icons.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ThemeColor themeColor = Get.put(ThemeColor());
  final TimeSettings timeSettings = Get.put(TimeSettings());
  TextEditingController controllerPomodoro = TextEditingController();
  TextEditingController controllerShort = TextEditingController();
  TextEditingController controllerLong = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (context) {
        return Obx(
          () => Container(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 700),
            // width: context.percentWidth * 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: context.percentHeight * 70,

            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(32),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  'Settings'
                                      .text
                                      .bold
                                      .size(32)
                                      .color(black)
                                      .textStyle(header)
                                      .make(),
                                  Icon(Icons.close).onTap(() {
                                    context.pop();
                                  })
                                ],
                              ),
                              18.heightBox,
                              Divider(
                                color: black.withOpacity(0.2),
                              ),
                              10.heightBox,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: 'TIME (MINUTES)'
                                    .text
                                    .size(16)
                                    .bold
                                    .letterSpacing(6)
                                    .color(black)
                                    .textStyle(subtitle1)
                                    .align(TextAlign.left)
                                    .make(),
                              ),
                              18.heightBox,
                              LayoutBuilder(builder: (context, dimen) {
                                if (dimen.maxWidth < 500) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          textHeading('pomodoro'),
                                          numberPicker(
                                              controller: controllerPomodoro,
                                              initial:
                                                  timeSettings.pomodoro.value),
                                        ],
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          textHeading('short'),
                                          numberPicker(
                                              controller: controllerShort,
                                              initial: timeSettings
                                                  .shortBreak.value),
                                        ],
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          textHeading('long'),
                                          numberPicker(
                                              controller: controllerLong,
                                              initial:
                                                  timeSettings.longBreak.value),
                                        ],
                                      )
                                    ],
                                  );
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        textHeading('pomodoro'),
                                        textHeading('short'),
                                        textHeading('long')
                                      ],
                                    ),
                                    6.heightBox,
                                    Container(
                                      height: 45,
                                      child: Row(
                                        children: [
                                          numberPicker(
                                              controller: controllerPomodoro,
                                              initial:
                                                  timeSettings.pomodoro.value),
                                          numberPicker(
                                              controller: controllerShort,
                                              initial: timeSettings
                                                  .shortBreak.value),
                                          numberPicker(
                                              controller: controllerLong,
                                              initial:
                                                  timeSettings.longBreak.value),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              18.heightBox,
                              Divider(
                                color: black.withOpacity(0.2),
                              ),
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  'COLOR'
                                      .text
                                      .size(16)
                                      .bold
                                      .letterSpacing(6)
                                      .color(black)
                                      .textStyle(subtitle1)
                                      .make(),
                                  Row(
                                    children: [
                                      VxCircle(
                                        radius: 40,
                                        backgroundColor:
                                            getColor(AvailableColors.orange),
                                        child: themeColor.main.value ==
                                                getColor(AvailableColors.orange)
                                            ? Icon(Icons.check)
                                            : Container(),
                                      ).onTap(() {
                                        themeColor
                                            .setTheme(AvailableColors.orange);
                                      }).p8(),
                                      VxCircle(
                                        radius: 40,
                                        backgroundColor:
                                            getColor(AvailableColors.blue),
                                        child: themeColor.main.value ==
                                                getColor(AvailableColors.blue)
                                            ? Icon(Icons.check)
                                            : Container(),
                                      ).onTap(() {
                                        themeColor
                                            .setTheme(AvailableColors.blue);
                                      }).p8(),
                                      VxCircle(
                                        radius: 40,
                                        backgroundColor:
                                            getColor(AvailableColors.pink),
                                        child: themeColor.main.value ==
                                                getColor(AvailableColors.pink)
                                            ? Icon(Icons.check)
                                            : Container(),
                                      ).onTap(() {
                                        themeColor
                                            .setTheme(AvailableColors.pink);
                                      }).p8()
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 180,
                          height: 60,
                          decoration: BoxDecoration(
                            color: themeColor.main.value,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                              child: Text(
                            "Apply",
                            style: subtitle1.copyWith(
                                color: black.withOpacity(0.8)),
                          )),
                        ).onTap(() {
                          timeSettings
                              .setPomodoro(int.parse(controllerPomodoro.text));
                          timeSettings
                              .setShort(int.parse(controllerShort.text));
                          timeSettings.setLong(int.parse(controllerLong.text));
                          context.pop();
                        }),
                      ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget textHeading(String t) {
    return t.text
        .size(14)
        .color(black.withOpacity(0.60))
        .semiBold
        .textStyle(subtitle1)
        .make()
        .marginSymmetric(horizontal: 12)
        .expand();
  }

  Widget numberPicker({TextEditingController controller, int initial}) {
    return NumberInputWithIncrementDecrement(
      controller: controller,
      numberFieldDecoration: InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: initial,
      incIconColor: black,
      decIconColor: black,
      widgetContainerDecoration: BoxDecoration(
        color: Color(0xffEEF1FA),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      separateIcons: false,
      incIconSize: 18,
      decIconSize: 18,
      incIcon: LineIcons.angleUp,
      decIcon: LineIcons.angleDown,
      min: 0,
      max: 59,
      autovalidate: true,
      style: subtitle1.copyWith(color: black, fontSize: 18),
    )
        .paddingOnly(right: 10)
        .box
        .color(Color(0xffEEF1FA))
        .withRounded(value: 10)
        .make()
        .marginSymmetric(horizontal: 12)
        .expand();
  }
}
