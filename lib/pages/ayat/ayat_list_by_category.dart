import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/category_controller.dart';
import 'package:rukiyah_and_ayat/controllers/verses_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/widgets/ayat_list_tab.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class AyatListByCategory extends StatefulWidget {
  final Category category;

  const AyatListByCategory({super.key, required this.category});

  @override
  State<AyatListByCategory> createState() => _AyatListByCategoryState();
}

class _AyatListByCategoryState extends State<AyatListByCategory> {
  final versesController = Get.find<VersesController>();
  String selectedFont = 'Amiri'; // Default font
  late List<Verse> verses;

  void _initCall() async {
    verses = await versesController.getVersesByCategory(
        categoryId: widget.category.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: const Icon(
                  Icons.settings,
                  color: WHITE,
                )),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => versesController.getVersesByCategoryLoading.value
              ? const Center(child: CustomLoader())
              : verses.isEmpty
                  ? const NoData(text:"কোনো আয়াত খুজে পাওয়া যায়নি",)
                  : ListView.separated(
                      itemCount: verses.length,
                      separatorBuilder: (_, i) => const SizedBox(
                        height: 16,
                        child: Divider(),
                      ),
                      itemBuilder: (context, index) => AyatCard(
                        verse: verses[index],
                        selectedFont: selectedFont,
                      ),
                    ),
        ),
      ),
    );

    //   DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text(widget.category.label),
    //       actions: [
    //         Padding(
    //           padding: const EdgeInsets.only(right: 16.0),
    //           child: IconButton(
    //               onPressed: () {
    //                 showDialog(
    //                   context: context,
    //                   builder: (context) {
    //                     return AlertDialog(
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(20.0)),
    //                       title: const Text('ফন্ট পরিবর্তন করুন'),
    //                       content: DropdownButton<String>(
    //                         value: selectedFont,
    //                         onChanged: (newValue) {
    //                           setState(() {
    //                             selectedFont = newValue!;
    //                           });
    //                           Navigator.pop(context); // Close the dialog
    //                         },
    //                         style: Theme.of(context).textTheme.titleSmall,
    //                         items: const [
    //                           DropdownMenuItem(
    //                             value: 'IBM Plex Sans Arabic',
    //                             child: Text('IBM Plex Sans Arabic'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Amiri',
    //                             child: Text('Amiri'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Lateef',
    //                             child: Text('Lateef'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Reem Kufi',
    //                             child: Text('Reem Kufi'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Tajawal',
    //                             child: Text('Tajawal'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'El Messiri',
    //                             child: Text('El Messiri'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Cairo',
    //                             child: Text('Cairo'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Almarai',
    //                             child: Text('Almarai'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Harmattan',
    //                             child: Text('Harmattan'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Noto Naskh Arabic',
    //                             child: Text('Noto Naskh Arabic'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Lalezar',
    //                             child: Text('Lalezar'),
    //                           ),
    //                           DropdownMenuItem(
    //                             value: 'Changa',
    //                             child: Text('Changa'),
    //                           ),
    //                           // Add more fonts here from Google Fonts
    //                         ],
    //                       ),
    //                     );
    //                   },
    //                 );
    //               },
    //               icon: const Icon(Icons.settings, color: WHITE,)),
    //         )
    //       ],
    //       bottom: TabBar(
    //         indicatorColor: WHITE,
    //         labelColor: WHITE,
    //         unselectedLabelColor: WHITE.withOpacity(0.5),
    //         tabs: const [
    //           Tab(text: "১ম অংশ",),
    //           Tab(text: "২য় অংশ",),
    //           Tab(text: "৩য় অংশ",),
    //         ],
    //       ),
    //     ),
    //     body: Container(
    //       padding: const EdgeInsets.all(16.0),
    //       child: FutureBuilder<List>(
    //         future: readData(),
    //         builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(child: CircularProgressIndicator());
    //           } else if (snapshot.hasError) {
    //             return Center(child: Text('Error: ${snapshot.error}'));
    //           } else if (snapshot.hasData) {
    //             List ayahList = snapshot.data!;
    //             int itemsPerTab = (ayahList.length / 3).ceil();
    //
    //             List firstTabItems = ayahList.sublist(0, itemsPerTab);
    //             List secondTabItems = ayahList.sublist(
    //                 itemsPerTab, itemsPerTab * 2 > ayahList.length ? ayahList.length : itemsPerTab * 2);
    //             List thirdTabItems = ayahList.sublist(
    //                 itemsPerTab * 2, ayahList.length);
    //
    //             return TabBarView(
    //               children: [
    //                 AyatListTab(ayahList: firstTabItems, selectedFont: selectedFont),
    //                 AyatListTab(ayahList: secondTabItems, selectedFont: selectedFont),
    //                 AyatListTab(ayahList: thirdTabItems, selectedFont: selectedFont),
    //               ],
    //             );
    //           } else {
    //             return const Center(child: Text('No data available')); // Display message for no data
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
