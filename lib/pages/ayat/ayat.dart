import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Ayat.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';

class AyatPage extends StatefulWidget {
  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  String selectedFont = 'Amiri'; // Default font
  List verses = [];
  List<CategoryDropdown> categories = <CategoryDropdown>[
    CategoryDropdown(value: "common", text: "রুকইয়ার সাধারণ আয়াত"),
    CategoryDropdown(value: "bodnojor", text: "বদনজর/হাসাদের আয়াত (শর্ট)"),
    CategoryDropdown(value: "bodnojorL", text: "বদনজর/হাসাদের আয়াত (লং)"),
    CategoryDropdown(value: "hasad", text: "হাসাদের আয়াত"),
    CategoryDropdown(value: "sihr", text: "সিহর (জাদুর) কমন আয়াত"),
    CategoryDropdown(value: "hark", text: "আয়াতুল হারক"),
    CategoryDropdown(value: "ajab", text: "আয়াতুল আযাব"),
    CategoryDropdown(value: "ajab_short", text: "আয়াতুল আযাব (শর্ট)"),
    CategoryDropdown(value: "kital", text: "আয়াতুল ক্বিতাল"),
    CategoryDropdown(value: "husun", text: "আয়াতুল হুসুন"),
    CategoryDropdown(value: "jin_shaitan", text: "আয়াতুল জ্বীন্নি ওয়াশ শায়তান"),
    CategoryDropdown(value: "fahishat", text: "আয়াতু জাম্মিল ফাহিশাত"),
    CategoryDropdown(value: "khuruj", text: "আয়াতুল খুরুজ"),
    CategoryDropdown(value: "hikmah", text: "আয়াতুল ইলমি ওয়াল হিকমাহ"),
    CategoryDropdown(value: "talak", text: "আয়াতুত তালাক ওয়াল আরহাম"),
  ];

  late CategoryDropdown selectedCategory;

  Future<List> readData() async {
    List ayahList = [];
    ByteData data = await rootBundle.load('assets/ayat.xlsx');

    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        ayahList.add(Ayat(
            title: row[0]!.value.toString(),
            verse: row[1]!.value.toString(),
            category: row[2]!.value.toString()));
      }
    }
    return ayahList;
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedCategory = categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('রুকইয়ার সাধারণ আয়াত'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<CategoryDropdown>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BORDER_COLOR_1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: BORDER_COLOR_1),
                ),
              ),
              value: selectedCategory,
              onChanged: (CategoryDropdown? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              dropdownColor: Colors.white,
              items: categories.map((CategoryDropdown category) {
                return DropdownMenuItem<CategoryDropdown>(
                  value: category,
                  child: Text(
                    category.text,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            verticalGap12,
            FutureBuilder<List>(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List ayahList = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: ayahList.length,
                      separatorBuilder: (_, index) => verticalGap12,
                      itemBuilder: (context, index) {
                        if (ayahList[index].category == selectedCategory.value) {
                          return AyatCard(
                            verse: ayahList[index],
                            selectedFont: selectedFont,
                          );
                        }
                        return Container();
                      },
                    ),
                  );
                } else {
                  return const Text(
                      'No data available'); // Display message for no data
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: const Text('ফন্ট পরিবর্তন করুন'),
                content: DropdownButton<String>(
                  value: selectedFont,
                  onChanged: (newValue) {
                    setState(() {
                      selectedFont = newValue!;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'IBM Plex Sans Arabic',
                      child: Text('IBM Plex Sans Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Amiri',
                      child: Text('Amiri'),
                    ),
                    DropdownMenuItem(
                      value: 'Lateef',
                      child: Text('Lateef'),
                    ),
                    DropdownMenuItem(
                      value: 'Reem Kufi',
                      child: Text('Reem Kufi'),
                    ),

                    DropdownMenuItem(
                      value: 'Tajawal',
                      child: Text('Tajawal'),
                    ),
                    DropdownMenuItem(
                      value: 'El Messiri',
                      child: Text('El Messiri'),
                    ),
                    DropdownMenuItem(
                      value: 'Cairo',
                      child: Text('Cairo'),
                    ),
                    DropdownMenuItem(
                      value: 'Almarai',
                      child: Text('Almarai'),
                    ),
                    DropdownMenuItem(
                      value: 'Harmattan',
                      child: Text('Harmattan'),
                    ),
                    DropdownMenuItem(
                      value: 'Noto Naskh Arabic',
                      child: Text('Noto Naskh Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Lalezar',
                      child: Text('Lalezar'),
                    ),
                    DropdownMenuItem(
                      value: 'Changa',
                      child: Text('Changa'),
                    ),
                    // Add more fonts here from Google Fonts
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.settings,
          color: Colors.black,
        ),
      ),
    );
  }
}
