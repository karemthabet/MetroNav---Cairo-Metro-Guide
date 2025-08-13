import 'package:flutter/material.dart';
import 'package:metro_app/pages/show_page.dart';
import 'package:metro_app/widgets/address_text_field.dart';
import 'package:metro_app/widgets/drop_down.dart';
import 'package:metro_app/widgets/my_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController textEditingController = TextEditingController();

  List<String> cairoMetroLine1 = [
    "المرج",
    "عين شمس",
    "حدائق الزيتون",
    "المطرية",
    "أرض المعارض",
    "عبده باشا",
    "الجيش",
    "السادات",
    "سعد زغلول",
    "السيدة زينب",
    "ماري جرجس",
    "الزمالك",
    "الأوبرا",
    "محمد نجيب",
    "الشهداء",
    "غمرة",
    "دار السلام",
    "حدائق المعادي",
    "المعادي",
    "ثكنات المعادي",
    "طرة الأسمنت",
    "كوتسيكا",
    "طرة البلد",
    "المعصرة",
    "حدائق حلوان",
    "جامعة حلوان",
    "وادي حوف",
    "حلوان",
  ];

  List<String> cairoMetroLine2 = [
    "شبرا الخيمة",
    "الخلفاوي",
    "سانت تريزا",
    "روض الفرج",
    "المساحة",
    "الشهداء", // انتقالي مع الخط الأول (الأحمر)
    "العتبة", // انتقالي مع الخط الثالث (الأرجواني)
    "محمد نجيب", // انتقالي مع الخط الأول (الأحمر)
    "السادات", // انتقالي مع الخط الأول (الأحمر)
    "الأوبرا",
    "الدقي",
    "البحوث",
    "فيصل",
    "جامعة القاهرة",
    "أبو بكر الصديق",
    "الهايكستب",
    "المنيب",
  ];

  List<String> cairoMetroLine3 = [
    "عدلي منصور",
    "الهايكستب",
    "عمر بن الخطاب",
    "قباء",
    "العباسية",
    "عبده باشا",
    "العتبة", // انتقالي مع الخط الثاني (الأزرق)
    "باب الشعرية",
    "الجيش", // انتقالي مع الخط الأول (الأحمر)
    "محمد نجيب", // انتقالي مع الخط الأول (الأحمر)
    "ماسبيرو",
    "السفارات",
    "الأهرام",
    "الكيلو 4.5",
    "النزهة",
    "النهضة",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323232),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/logo.png', width: 70),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: DropDown(
              label: 'محطة البداية',
              cairoMetroLine1: cairoMetroLine1,
              cairoMetroLine2: cairoMetroLine2,
              cairoMetroLine3: cairoMetroLine3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: DropDown(
              label: 'محطة الوصول',
              cairoMetroLine1: cairoMetroLine1,
              cairoMetroLine2: cairoMetroLine2,
              cairoMetroLine3: cairoMetroLine3,
            ),
          ),
          const SizedBox(height: 25),
          MyButton(
            text: 'عرض',
            color: Colors.red,
            widthButton: .75,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowPage()),
              );
            },
          ),
          const SizedBox(height: 8),
          MyButton(
            text: "أقرب محطة",
            widthButton: .25,
            color: Color(0xFFBCBCBC),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: AddressTextField(
              textController: textEditingController,
              label: 'أدخل العنوان المتجه اليه',
            ),
          ),
        ],
      ),
    );
  }
}
