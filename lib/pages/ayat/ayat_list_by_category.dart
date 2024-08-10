import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Ayat.dart';
import 'package:rukiyah_and_ayat/widgets/ayat_list_tab.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';

class AyatListByCategory extends StatefulWidget {
  final Category category;

  const AyatListByCategory({super.key, required this.category});

  @override
  State<AyatListByCategory> createState() => _AyatListByCategoryState();
}

class _AyatListByCategoryState extends State<AyatListByCategory> {
  String selectedFont = 'Amiri'; // Default font
  List verses = [];

  Future<List> readData() async {
    List ayahList = [];
    ByteData data = await rootBundle.load('assets/ayat.xlsx');

    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[2]!.value.toString() == widget.category.value) {
          ayahList.add(
            Ayat(
              title: row[0]!.value.toString(),
              verse: row[1]!.value.toString(),
              category: row[2]!.value.toString(),
            ),
          );
        }
      }
    }
    return ayahList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.label),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
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
                            style: Theme.of(context).textTheme.titleSmall,
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
                  icon: const Icon(Icons.settings, color: WHITE,)),
            )
          ],
          bottom: TabBar(
            indicatorColor: WHITE,
            labelColor: WHITE,
            unselectedLabelColor: WHITE.withOpacity(0.5),
            tabs: const [
              Tab(text: "১ম অংশ",),
              Tab(text: "২য় অংশ",),
              Tab(text: "৩য় অংশ",),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List>(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List ayahList = snapshot.data!;
                int itemsPerTab = (ayahList.length / 3).ceil();

                List firstTabItems = ayahList.sublist(0, itemsPerTab);
                List secondTabItems = ayahList.sublist(
                    itemsPerTab, itemsPerTab * 2 > ayahList.length ? ayahList.length : itemsPerTab * 2);
                List thirdTabItems = ayahList.sublist(
                    itemsPerTab * 2, ayahList.length);

                return TabBarView(
                  children: [
                    AyatListTab(ayahList: firstTabItems, selectedFont: selectedFont),
                    AyatListTab(ayahList: secondTabItems, selectedFont: selectedFont),
                    AyatListTab(ayahList: thirdTabItems, selectedFont: selectedFont),
                  ],
                );
              } else {
                return const Center(child: Text('No data available')); // Display message for no data
              }
            },
          ),
        ),
      ),
    );
  }
}
