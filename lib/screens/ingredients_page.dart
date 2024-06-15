import 'dart:typed_data';

import 'package:flutter/material.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key, this.image});
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: (image != null)
                  ? Image.memory(image!)
                  : const Center(
                      child: Text('Null'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
