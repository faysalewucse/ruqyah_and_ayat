import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final dataController = Get.find<DataController>();

  void _initCall() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
    await dataController.initDataController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCall();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
