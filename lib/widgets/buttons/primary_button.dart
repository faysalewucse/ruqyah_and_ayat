import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const PrimaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: rounded6Primary,
        child: Text(label, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
      ),
    );
  }
}
