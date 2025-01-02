import 'package:bmi/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  late Box<dynamic> _savedDataBox;

  @override
  void initState() {
    super.initState();
    _savedDataBox = Hive.box('savedData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ذخیره ها",
          style: TextStyle(
              color: blackColor,
              fontSize: calcuteWidth(64, context),
              fontFamily: Fonts.VazirBlack.fontFamily),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final box = Hive.box('savedData');
                setState(() async {
                  await box.clear(); // حذف تمام داده‌ها
                });
              },
              icon: const Icon(CupertinoIcons.trash))
        ],
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: ValueListenableBuilder(
        valueListenable: _savedDataBox.listenable(),
        builder: (context, Box<dynamic> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text(
                "هیچ اطلاعاتی ذخیره نشده است",
                style: TextStyle(
                    fontFamily: Fonts.Vazir.fontFamily,
                    fontSize: calcuteWidth(50, context),
                    color: blackColor),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  ...box.values.map((data) {
                    return Card(
                      context,
                      data['image'] ?? "assets/10.png",
                      data['state'] ?? "نامشخص",
                      data['weight'] ?? "0",
                      data['height'] ?? "0",
                      data['bmi'] ?? "0.0",
                    );
                  }),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding Card(BuildContext context, String image, String state,
      String weight, String height, String bmi) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: calcuteWidth(854, context),
        height: calcuteWidth(520, context),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(calcuteWidth(77, context))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: calcuteWidth(58, context)),
          child: Row(
            children: [
              SizedBox(
                width: calcuteWidth(130, context),
                child: Image.asset(image),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "وضعیت",
                        style: TextStyle(
                            fontFamily: Fonts.VazirBold.fontFamily,
                            fontSize: calcuteWidth(41, context),
                            color: const Color(0xff373737)),
                      ),
                      Text(
                        "شما $state دارید",
                        style: TextStyle(
                            fontFamily: Fonts.ExtraBold.fontFamily,
                            fontSize: calcuteWidth(50, context)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardProperty(context, "BMI", bmi),
                        CardProperty(context, "قد", height),
                        CardProperty(context, "وزن", weight),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Padding CardProperty(BuildContext context, String title, String caption) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: Fonts.VazirBold.fontFamily,
                fontSize: calcuteWidth(35, context),
                color: const Color(0xff373737)),
          ),
          Text(
            caption,
            style: TextStyle(
                fontFamily: Fonts.ExtraBold.fontFamily,
                fontSize: calcuteWidth(44, context),
                color: blackColor),
          ),
        ],
      ),
    );
  }
}
