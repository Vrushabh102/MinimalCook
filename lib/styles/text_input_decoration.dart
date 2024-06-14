import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';

InputDecoration textInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: IconButton(
      onPressed: () {
        
      },
      icon: const Icon(Icons.search),
    ),
    contentPadding: const EdgeInsets.fromLTRB(28, 20, 10, 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
      borderSide: const BorderSide(
        color: Colors.blue,
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
