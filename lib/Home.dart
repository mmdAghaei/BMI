import 'package:bmi/Color.dart';
import 'package:bmi/Resoult.dart';
import 'package:bmi/Save.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool ClickGender = false;

class _HomeState extends State<Home> {
  void _showFeedbackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'نظر شما برایمان مهم است',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'لطفاً نظر خود را درباره برنامه توده بدنی ثبت کنید.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(grayColor),
                    ),
                    onPressed: () async {
                      await launchUrl(Uri.parse(url));
                      Navigator.pop(context);
                    },
                    child: Text('ثبت نظر'),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(grayColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('بیخیال'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  RulerPickerController? _rulerPickerController;

  num currentValue = 150;
  int _currentValue = 50;
  int _currentValueAge = 20;

  List<RulerRange> ranges = const [
    RulerRange(begin: 0, end: 300, scale: 1),
  ];

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "شاخص توده بدنی",
          style: TextStyle(
              color: blackColor,
              fontSize: calcuteWidth(64, context),
              fontFamily: Fonts.VazirBlack.fontFamily),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
              onPressed: () => _showFeedbackSheet(context),
              icon: Icon(
                CupertinoIcons.star,
                color: blackColor,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SavePage(),
                  ));
            },
            icon: Icon(
              CupertinoIcons.bookmark,
              color: blackColor,
            )),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardGender(context, "female"),
              CardGender(context, "male"),
            ],
          ),
          Container(
            width: calcuteWidth(1029, context),
            height: calcuteWidth(555, context),
            decoration: BoxDecoration(
                color: fillCard,
                border: Border.all(color: blackColor.withOpacity(.5)),
                borderRadius: BorderRadius.circular(calcuteWidth(53, context))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "قد",
                  style: TextStyle(
                      color: textColor,
                      fontSize: calcuteWidth(64, context),
                      fontFamily: Fonts.VazirMedium.fontFamily),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (currentValue - 2).toStringAsFixed(1),
                      style: TextStyle(color: blackColor),
                    ),
                    RulerPicker(
                      controller: _rulerPickerController!,
                      onBuildRulerScaleText: (index, value) {
                        return value.toInt().toString();
                      },
                      ranges: ranges,
                      rulerBackgroundColor: Colors.black.withOpacity(0),
                      scaleLineStyleList: [
                        ScaleLineStyle(
                            color: blackColor,
                            width: 1.5,
                            height: 30,
                            scale: 0),
                        ScaleLineStyle(
                            color: blackColor, width: 1, height: 25, scale: 5),
                        ScaleLineStyle(
                            color: blackColor, width: 1, height: 15, scale: -1)
                      ],
                      onValueChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      rulerMarginTop: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: calcuteWidth(485, context),
                height: calcuteWidth(485, context),
                decoration: BoxDecoration(
                    color: fillCard,
                    border: Border.all(
                        color: blackColor.withOpacity(.5),
                        width: calcuteWidth(5, context)),
                    borderRadius:
                        BorderRadius.circular(calcuteWidth(53, context))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "وزن",
                      style: TextStyle(
                          color: textColor,
                          fontSize: calcuteWidth(64, context),
                          fontFamily: Fonts.VazirMedium.fontFamily),
                    ),
                    NumberPicker(
                      axis: Axis.horizontal,
                      textStyle: TextStyle(
                        color: blackColor.withOpacity(.7),
                      ),
                      selectedTextStyle: TextStyle(
                          color: blackColor.withOpacity(.8), fontSize: 25),
                      minValue: 1,
                      itemHeight: 45,
                      itemWidth: 45,
                      // itemCount: 7,
                      maxValue: 200,
                      value: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: calcuteWidth(485, context),
                height: calcuteWidth(485, context),
                decoration: BoxDecoration(
                    color: fillCard,
                    border: Border.all(
                        color: blackColor.withOpacity(.5),
                        width: calcuteWidth(5, context)),
                    borderRadius:
                        BorderRadius.circular(calcuteWidth(53, context))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "سن",
                      style: TextStyle(
                          color: textColor,
                          fontSize: calcuteWidth(64, context),
                          fontFamily: Fonts.VazirMedium.fontFamily),
                    ),
                    NumberPicker(
                      axis: Axis.horizontal,
                      textStyle: TextStyle(
                        color: blackColor.withOpacity(.7),
                      ),
                      selectedTextStyle: TextStyle(
                          color: blackColor.withOpacity(.8), fontSize: 25),
                      minValue: 1,
                      itemHeight: 45,
                      itemWidth: 45,
                      // itemCount: 7,
                      maxValue: 100,
                      value: _currentValueAge,
                      onChanged: (value) {
                        setState(() {
                          _currentValueAge = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: calcuteWidth(550, context),
            height: calcuteWidth(170, context),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Resoult(
                        age: _currentValueAge,
                        gender: ClickGender == false ? 1 : 0,
                        heigth: (currentValue - 2).toString(),
                        weigth: _currentValue,
                      ),
                    ));
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(textColor)),
              child: Text(
                "حساب کردن",
                style: TextStyle(
                    color: backgroundColor,
                    fontFamily: Fonts.VazirBold.fontFamily,
                    fontSize: calcuteWidth(64, context)),
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell CardGender(BuildContext context, String gender) {
    return InkWell(
      borderRadius: BorderRadius.circular(calcuteWidth(53, context)),
      onTap: () {
        setState(() {
          gender == "female" ? ClickGender = true : ClickGender = false;
        });
      },
      child: Container(
        width: calcuteWidth(485, context),
        height: calcuteWidth(485, context),
        decoration: BoxDecoration(
            color: fillCard,
            border: Border.all(
                color: blackColor.withOpacity(.5),
                width: calcuteWidth(
                    gender == "female"
                        ? ClickGender
                            ? 10
                            : 5
                        : ClickGender
                            ? 5
                            : 10,
                    context)),
            borderRadius: BorderRadius.circular(calcuteWidth(53, context))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: calcuteWidth(275, context),
              height: calcuteWidth(275, context),
              child: Image.asset(
                  gender == "female" ? "assets/frmale.png" : "assets/male.png"),
            ),
            Text(
              gender == "female" ? "زن" : "مرد",
              style: TextStyle(
                  color: textColor,
                  fontFamily: gender == "female"
                      ? ClickGender
                          ? Fonts.ExtraBold.fontFamily
                          : Fonts.VazirMedium.fontFamily
                      : ClickGender
                          ? Fonts.VazirMedium.fontFamily
                          : Fonts.ExtraBold.fontFamily,
                  fontSize: calcuteWidth(64, context)),
            )
          ],
        ),
      ),
    );
  }
}
