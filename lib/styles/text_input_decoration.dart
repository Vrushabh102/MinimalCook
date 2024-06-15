import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';

InputDecoration textInputDecoration(String hintText, BuildContext context) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    ),
    contentPadding: const EdgeInsets.fromLTRB(28, 20, 10, 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: BorderSide(
        color: Theme.of(context).brightness == Brightness.dark
            ? shakaYellow
            : shakadarkerYellow,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: BorderSide(
        color: Theme.of(context).brightness == Brightness.dark
            ? shakaYellow
            : shakadarkerYellow,
        width: 1.9,
      ),
    ),
  );
}

InputDecoration ingredientsInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(28, 20, 10, 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: shakaYellow,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: shakaYellow,
        width: 1.5,
      ),
    ),
  );
}
