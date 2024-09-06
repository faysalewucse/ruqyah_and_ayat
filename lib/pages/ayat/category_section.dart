import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/data/data.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/common_functions.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("আয়াত"),
      ),
      body: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: rounded20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "فَلَمَّا أَلْقَوْا قَالَ مُوسَىٰ مَا جِئْتُم بِهِ السِّحْرُ ۖ إِنَّ اللَّهَ سَيُبْطِلُهُ ۖ إِنَّ اللَّهَ لَا يُصْلِحُ عَمَلَ الْمُفْسِدِينَ",
                      textAlign: TextAlign.center,
                      style: white16W600Arabic),
                  verticalGap12,
                  Text(
                      "অতঃপর তারা (ফেরাউনের হায়ার করা জাদুকররা ) যখন (লাঠি ও রশি) নিক্ষেপ করল তখন মূসা বলল, ‘তোমরা যা এনেছো তা জাদু, নিশ্চয়ই আল্লাহ্ একে অসার করে দিবেন। আল্লাহ্ অবশ্যই অশান্তি সৃষ্টিকারীদের কর্ম সার্থক করেন না।’",
                      textAlign: TextAlign.center,
                      style: white16W600),
                  verticalGap12,
                  Text("“সূরাঃ ইউনুস (১০ঃ৮১)”",
                      textAlign: TextAlign.center, style: white14W500),
                ],
              ),
            ),
            16.kH,
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: parts.length,
                itemBuilder: (context, index) {
                  return MaterialButton(
                    onPressed: () {
                      Get.toNamed(categories, arguments: index+1);
                    },
                    color: Theme.of(context).cardColor,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: const EdgeInsets.all(16.0),
                    // Padding inside the button
                    child: Center(
                      child: Text(
                        parts[index],
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(
                label: "ওয়েবসাইট ভিজিট করুন",
                onTap: () {
                  launchInBrowser(Uri.parse(WEBSITE_URL));
                }),
          ],
        ),
      ),
    );
  }
}
