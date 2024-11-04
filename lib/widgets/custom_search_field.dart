import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) filterMethod;
  final String hintText;
  const CustomSearchField({super.key, required this.searchController, required this.filterMethod, required this.hintText});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.filterMethod(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: "${widget.hintText} খুজুন...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: rounded20,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
      ),
    );
  }
}
