import 'package:bmi/Color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Resoult extends StatefulWidget {
  final int gender;
  final int age;
  final int weigth;
  final String heigth;
  const Resoult(
      {super.key,
      required this.gender,
      required this.age,
      required this.weigth,
      required this.heigth});

  @override
  State<Resoult> createState() => _ResoultState();
}

class _ResoultState extends State<Resoult> {
  double _sliderValue = 1;
  Color _selectedColor = Colors.red;
  double BMI = 0;
  String ResBmi = "";
  double BestWeigth1 = 0;
  double BestWeigth2 = 0;
  double BMRMAN = 0;
  double BMRWOMAN = 0;
  String image = "";

  void _updateColor(double value) {
    int index = (value * (timelineColors.length - 1)).round();
    setState(() {
      _sliderValue = value;
      _selectedColor = timelineColors[index];
    });
  }

  bool chacked = false;
  @override
  void initState() {
    super.initState();
    BMI = widget.weigth /
        ((double.parse(widget.heigth) / 100) *
            (double.parse(widget.heigth) / 100));

    if (BMI < 18.5) {
      ResBmi = "کمبود وزن";
      image = widget.gender == 1 ? "assets/11.png" : "assets/10.png";
    } else if (BMI > 18.5 && BMI < 24.9) {
      ResBmi = "وزن سالم";
      image = widget.gender == 1 ? "assets/21.png" : "assets/20.png";
    } else if (BMI > 25 && BMI < 29.9) {
      ResBmi = "اضافه وزن";
      image = widget.gender == 1 ? "assets/31.png" : "assets/30.png";
    } else if (BMI > 30) {
      ResBmi = "چاقی";
      image = widget.gender == 1 ? "assets/41.png" : "assets/40.png";
    }
    BestWeigth1 = 18.5 *
        ((double.parse(widget.heigth) / 100) *
            (double.parse(widget.heigth) / 100));
    BestWeigth2 = 24.9 *
        ((double.parse(widget.heigth) / 100) *
            (double.parse(widget.heigth) / 100));

    BMRMAN = 88.362 +
        (13.397 * widget.weigth) +
        (4.799 * (double.parse(widget.heigth) / 100)) -
        (5.677 * widget.age);
    BMRWOMAN = 447.593 +
        (9.247 * widget.weigth) +
        (3.098 * (double.parse(widget.heigth) / 100)) -
        (4.330 * widget.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: calcuteWidth(1013, context),
              height: calcuteWidth(1600, context) +
                  (calcuteWidth(110, context) / 2),
              alignment: Alignment.center,
              // color: Colors.red,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: calcuteWidth(1013, context),
                      height: calcuteWidth(1600, context),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.5)),
                          borderRadius:
                              BorderRadius.circular(calcuteWidth(53, context))),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: calcuteWidth(177, context)),
                            child: Column(
                              children: [
                                Container(
                                  width: calcuteWidth(911, context),
                                  height: 7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: timelineColors,
                                      stops: timelineStops,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: Slider(
                                    value: BMI > 39 ? 39 : BMI,
                                    onChanged: (value) {},
                                    min: 0,
                                    max: 40,
                                    thumbColor: Colors.black,
                                    activeColor: Colors.transparent,
                                    inactiveColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  width: calcuteWidth(911, context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "کمبود وزن",
                                        style: TextStyle(
                                            fontSize: calcuteWidth(30, context),
                                            fontFamily:
                                                Fonts.VazirBold.fontFamily),
                                      ),
                                      Text(
                                        "چاقی شدید",
                                        style: TextStyle(
                                            fontSize: calcuteWidth(30, context),
                                            fontFamily:
                                                Fonts.VazirBold.fontFamily),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: calcuteWidth(40, context)),
                            child: Column(
                              children: [
                                Text(
                                  "شما $ResBmi دارید",
                                  style: TextStyle(
                                      fontFamily: Fonts.VazirBold.fontFamily,
                                      fontSize: calcuteWidth(40, context)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: calcuteWidth(322, context),
                                    child: Image.asset(image)),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CardProperty(context, "شاخص توده بدنی",
                                          BMI.toStringAsFixed(2)),
                                      CardProperty(context, "محدوده وزن سالم",
                                          "${BestWeigth1.toStringAsFixed(0)}~${BestWeigth2.toStringAsFixed(0)}"),
                                      CardProperty(
                                          context,
                                          "نرخ متابولیسم پایه",
                                          (widget.gender == 1 ? BMRMAN : BMRWOMAN).toStringAsFixed(2)),
                                      CardProperty(context, "نیاز روزانه کالری",
                                          (widget.gender == 1 ? BMRMAN * 1.55 : BMRWOMAN * 1.55).toStringAsFixed(2)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(500),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: calcuteWidth(110, context),
                              height: calcuteWidth(110, context),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff787979)),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(500),
                            onTap: () async {
                              final box = Hive.box('savedData');
                              box.add({
                                'image': image,
                                'state': ResBmi,
                                'weight': (widget.weigth).toString(),
                                'height':
                                    (double.parse(widget.heigth)).toString(),
                                'bmi': (BMI.toStringAsFixed(2)).toString(),
                              });
                              setState(() {
                                chacked = !chacked;
                              });
                            },
                            child: Container(
                              width: calcuteWidth(110, context),
                              height: calcuteWidth(110, context),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff787979)),
                              child: Icon(
                                chacked
                                    ? Icons.bookmark_outlined
                                    : Icons.bookmark_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding CardProperty(BuildContext context, String title, String caption) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: Fonts.Vazir.fontFamily,
                fontSize: calcuteWidth(48, context),
                color: grayColor),
          ),
          Text(
            caption,
            style: TextStyle(
                fontFamily: Fonts.VazirBold.fontFamily,
                fontSize: calcuteWidth(48, context),
                color: blackColor),
          ),
        ],
      ),
    );
  }
}
