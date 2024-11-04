import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Widget? suffix;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.suffix, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: rounded20,
      child: InkWell(
        onTap: onTap,
        borderRadius: rounded20,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: rounded20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              if (suffix != null)
                Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: suffix,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
